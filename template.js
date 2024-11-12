const sendHttpRequest = require('sendHttpRequest');
const encodeUriComponent = require('encodeUriComponent');
const JSON = require('JSON');
const templateDataStorage = require('templateDataStorage');
const Promise = require('Promise');
const sha256Sync = require('sha256Sync');
const logToConsole = require('logToConsole');
const getRequestHeader = require('getRequestHeader');
const getContainerVersion = require('getContainerVersion');

const isLoggingEnabled = determinateIsLoggingEnabled();
const traceId = isLoggingEnabled ? getRequestHeader('trace-id') : undefined;

if (data.lookupType == "document" && !data.documentId) {
  return null;
}

return getResponseBody().then(mapResponse);

function getOptions() {
  return {method: 'POST', headers: { 'Content-Type': 'application/json' }};
}

function mapResponse(bodyString) {
  const body = JSON.parse(bodyString);
  let document = body && body.length > 0 ? body[0] : {};
  document = document.data || {};

  if (!data.documentPath) return document;

  const keys = data.documentPath.trim().split('.');
  let value = document;
  for (let i = 0; i < keys.length; i++) {
    const key = keys[i];
    if (!value || !key) break;
    value = value[key];
  }

  return value;
}

function getPostBody() {
  if (data.lookupType === 'document') {
    return {
      key: data.documentId,
      limit: 1
    };
  }

  let filters = [];

  for (let i = 0; i < data.queryConditions.length; i++) {
    const condition = data.queryConditions[i];

    filters.push([
      condition.field,
      condition.operator,
      condition.value
    ]);
  }

  return {
    data: filters,
    limit: 1
  };
}

function getResponseBody() {
  const url = getStoreUrl();
  const options = getOptions();
  const postBody = getPostBody();
  const cacheKey = data.storeResponse ? sha256Sync(url + JSON.stringify(postBody)) : '';

  if (data.storeResponse) {
    const cachedValue = templateDataStorage.getItemCopy(cacheKey);
    if (cachedValue) return Promise.create((resolve) => resolve(cachedValue));
  }

  if (isLoggingEnabled) {
    logToConsole(
      JSON.stringify({
        Name: 'StapeStore',
        Type: 'Request',
        TraceId: traceId,
        EventName: 'StoreRead',
        RequestMethod: options.method,
        RequestUrl: url,
        RequestBody: postBody,
      })
    );
  }
  return sendHttpRequest(url, options, JSON.stringify(postBody)).then((response) => {
    if (isLoggingEnabled) {
      logToConsole(
        JSON.stringify({
          Name: 'StapeStore',
          Type: 'Response',
          TraceId: traceId,
          EventName: 'StoreRead',
          ResponseStatusCode: response.statusCode,
          ResponseHeaders: response.headers,
          ResponseBody: response.body,
        })
      );
    }

    if (data.storeResponse) templateDataStorage.setItemCopy(cacheKey, response.body);

    return response.body;
  });
}

function getStoreUrl() {
  const containerIdentifier = getRequestHeader('x-gtm-identifier');
  const defaultDomain = getRequestHeader('x-gtm-default-domain');
  const containerApiKey = getRequestHeader('x-gtm-api-key');

  return (
    'https://' +
    enc(containerIdentifier) +
    '.' +
    enc(defaultDomain) +
    '/stape-api/' +
    enc(containerApiKey) +
    '/v1/store'
  );
}

function determinateIsLoggingEnabled() {
  const containerVersion = getContainerVersion();
  const isDebug = !!(containerVersion && (containerVersion.debugMode || containerVersion.previewMode));

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

function enc(data) {
  data = data || '';
  return encodeUriComponent(data);
}
