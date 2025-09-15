/// <reference path="./server-gtm-sandboxed-apis.d.ts" />

const sendHttpRequest = require('sendHttpRequest');
const encodeUriComponent = require('encodeUriComponent');
const JSON = require('JSON');
const templateDataStorage = require('templateDataStorage');
const Promise = require('Promise');
const sha256Sync = require('sha256Sync');
const logToConsole = require('logToConsole');
const getRequestHeader = require('getRequestHeader');
const getContainerVersion = require('getContainerVersion');
const makeString = require('makeString');
const getTimestampMillis = require('getTimestampMillis');
const getType = require('getType');
const BigQuery = require('BigQuery');

/*==============================================================================
==============================================================================*/

const traceId = getRequestHeader('trace-id');

if (data.lookupType === 'document' && !data.documentId) {
  return null;
}

return lookupInStore(data).then(mapResponse);

/*==============================================================================
  Vendor related functions
==============================================================================*/

function getStoreBaseUrl(data) {
  const containerIdentifier = getRequestHeader('x-gtm-identifier');
  const defaultDomain = getRequestHeader('x-gtm-default-domain');
  const containerApiKey = getRequestHeader('x-gtm-api-key');
  const collectionPath = 'collections/' + enc(data.collectionName || 'default') + '/documents';

  return (
    'https://' +
    enc(containerIdentifier) +
    '.' +
    enc(defaultDomain) +
    '/stape-api/' +
    enc(containerApiKey) +
    '/v2/store/' +
    collectionPath
  );
}

function getDocumentUrl(data, documentId) {
  const storeBaseUrl = getStoreBaseUrl(data);
  return storeBaseUrl + '/' + enc(documentId);
}

function getOptions(data) {
  const optionsByLookupType = {
    document: { method: 'GET' },
    query: { method: 'POST', headers: { 'Content-Type': 'application/json' } }
  };

  return optionsByLookupType[data.lookupType];
}

function getLookupByQueryBody(data) {
  const filterConditions = [];

  if (data.queryConditions) {
    data.queryConditions.forEach((filterCondition) => {
      filterConditions.push({
        field: filterCondition.field,
        operator: filterCondition.operator,
        value: filterCondition.value
      });
    });
  }

  return {
    filter: {
      operator: 'and',
      conditions: filterConditions
    },
    pagination: {
      limit: 1
    }
  };
}

function lookupInStore(data) {
  const url =
    data.lookupType === 'document' ? getDocumentUrl(data, data.documentId) : getStoreBaseUrl(data);
  const options = getOptions(data);
  const body = data.lookupType === 'query' ? getLookupByQueryBody(data) : undefined;
  const bodyStrigified = body ? JSON.stringify(body) : undefined;
  const cacheKey = data.storeResponse ? sha256Sync(url + bodyStrigified || '') : '';

  if (data.storeResponse) {
    const cachedValue = templateDataStorage.getItemCopy(cacheKey);
    if (cachedValue) return Promise.create((resolve) => resolve(cachedValue));
  }

  log({
    Name: 'StapeStore',
    Type: 'Request',
    TraceId: traceId,
    EventName: 'StoreRead',
    RequestMethod: options.method,
    RequestUrl: url,
    RequestBody: body
  });

  return sendHttpRequest(url, options, bodyStrigified).then((response) => {
    log({
      Name: 'StapeStore',
      Type: 'Response',
      TraceId: traceId,
      EventName: 'StoreRead',
      ResponseStatusCode: response.statusCode,
      ResponseHeaders: response.headers,
      ResponseBody: response.body
    });

    if (data.storeResponse) templateDataStorage.setItemCopy(cacheKey, response.body);

    return response.body;
  });
}

function getDocumentFromResponseBody(body) {
  if (getType(body) !== 'object' || getType(body.data) !== 'object') return {};

  if (data.lookupType === 'document') {
    return body.data;
  } else if (
    data.lookupType === 'query' &&
    getType(body.data.items) === 'array' &&
    getType(body.data.items[0]) === 'object'
  ) {
    return body.data.items[0];
  }

  return {};
}

function mapResponse(bodyString) {
  const body = JSON.parse(bodyString || '{}');
  const document = getDocumentFromResponseBody(body);
  const storedData = document.data || {};

  if (!data.documentPath) return storedData;

  const keys = data.documentPath.trim().split('.');
  let value = storedData;
  for (let i = 0; i < keys.length; i++) {
    const key = keys[i];
    if (!value || !key) break;
    value = value[key];
  }
  return value;
}

/*==============================================================================
  Helpers
==============================================================================*/

function enc(data) {
  return encodeUriComponent(makeString(data || ''));
}

function log(rawDataToLog) {
  const logDestinationsHandlers = {};
  if (determinateIsLoggingEnabled()) logDestinationsHandlers.console = logConsole;
  if (determinateIsLoggingEnabledForBigQuery()) logDestinationsHandlers.bigQuery = logToBigQuery;

  const keyMappings = {
    // No transformation for Console is needed.
    bigQuery: {
      Name: 'tag_name',
      Type: 'type',
      TraceId: 'trace_id',
      EventName: 'event_name',
      RequestMethod: 'request_method',
      RequestUrl: 'request_url',
      RequestBody: 'request_body',
      ResponseStatusCode: 'response_status_code',
      ResponseHeaders: 'response_headers',
      ResponseBody: 'response_body'
    }
  };

  for (const logDestination in logDestinationsHandlers) {
    const handler = logDestinationsHandlers[logDestination];
    if (!handler) continue;

    const mapping = keyMappings[logDestination];
    const dataToLog = mapping ? {} : rawDataToLog;

    if (mapping) {
      for (const key in rawDataToLog) {
        const mappedKey = mapping[key] || key;
        dataToLog[mappedKey] = rawDataToLog[key];
      }
    }

    handler(dataToLog);
  }
}

function logConsole(dataToLog) {
  logToConsole(JSON.stringify(dataToLog));
}

function logToBigQuery(dataToLog) {
  const connectionInfo = {
    projectId: data.logBigQueryProjectId,
    datasetId: data.logBigQueryDatasetId,
    tableId: data.logBigQueryTableId
  };

  dataToLog.timestamp = getTimestampMillis();

  ['request_body', 'response_headers', 'response_body'].forEach((p) => {
    dataToLog[p] = JSON.stringify(dataToLog[p]);
  });

  BigQuery.insert(connectionInfo, [dataToLog], { ignoreUnknownValues: true });
}

function determinateIsLoggingEnabled() {
  const containerVersion = getContainerVersion();
  const isDebug = !!(
    containerVersion &&
    (containerVersion.debugMode || containerVersion.previewMode)
  );

  if (!data.logType) {
    return isDebug;
  }

  if (data.logType === 'no') {
    return false;
  }

  if (data.logType === 'debug') {
    return isDebug;
  }

  return data.logType === 'always';
}

function determinateIsLoggingEnabledForBigQuery() {
  if (data.bigQueryLogType === 'no') return false;
  return data.bigQueryLogType === 'always';
}
