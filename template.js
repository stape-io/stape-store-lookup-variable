const encodeUriComponent = require('encodeUriComponent');
const getRequestHeader = require('getRequestHeader');
const getType = require('getType');
const JSON = require('JSON');
const makeString = require('makeString');
const Promise = require('Promise');
const sendHttpRequest = require('sendHttpRequest');
const sha256Sync = require('sha256Sync');
const templateDataStorage = require('templateDataStorage');

/*==============================================================================
==============================================================================*/

if (data.lookupType === 'document' && !data.documentId) {
  return null;
}

return lookupInStore(data).then(mapResponse);

/*==============================================================================
  Vendor related functions
==============================================================================*/

function getStapeStoreBaseUrl(data) {
  let containerIdentifier;
  let defaultDomain;
  let containerApiKey;
  const collectionPath =
    'collections/' + enc(data.stapeStoreCollectionName || 'default') + '/documents';

  const shouldUseDifferentStore =
    isUIFieldTrue(data.useDifferentStapeStore) &&
    getType(data.stapeStoreContainerApiKey) === 'string';
  if (shouldUseDifferentStore) {
    const containerApiKeyParts = data.stapeStoreContainerApiKey.split(':');

    const containerLocation = containerApiKeyParts[0];
    const containerRegion = containerApiKeyParts[3] || 'io';
    containerIdentifier = containerApiKeyParts[1];
    defaultDomain = containerLocation + '.stape.' + containerRegion;
    containerApiKey = containerApiKeyParts[2];
  } else {
    containerIdentifier = getRequestHeader('x-gtm-identifier');
    defaultDomain = getRequestHeader('x-gtm-default-domain');
    containerApiKey = getRequestHeader('x-gtm-api-key');
  }

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

function getStapeStoreDocumentUrl(data, documentId) {
  const storeBaseUrl = getStapeStoreBaseUrl(data);
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
    data.lookupType === 'document'
      ? getStapeStoreDocumentUrl(data, data.documentId)
      : getStapeStoreBaseUrl(data);
  const options = getOptions(data);
  const body = data.lookupType === 'query' ? getLookupByQueryBody(data) : undefined;
  const bodyStrigified = body ? JSON.stringify(body) : undefined;
  const cacheKey = data.storeResponse ? sha256Sync(url + bodyStrigified || '') : '';

  if (data.storeResponse) {
    const cachedValue = templateDataStorage.getItemCopy(cacheKey);
    if (cachedValue) return Promise.create((resolve) => resolve(cachedValue));
  }

  return sendHttpRequest(url, options, bodyStrigified).then((response) => {
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

function isUIFieldTrue(field) {
  return [true, 'true', 1, '1'].indexOf(field) !== -1;
}

function enc(data) {
  if (['null', 'undefined'].indexOf(getType(data)) !== -1) data = '';
  return encodeUriComponent(makeString(data));
}
