___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Stape Store Lookup",
  "categories": [
    "UTILITY",
    "DATA_WAREHOUSING"
  ],
  "description": "Retrieves data from Stape Store. Looks up a specific document by its ID or queries a collection to find a document that matches certain criteria.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "RADIO",
    "name": "lookupType",
    "displayName": "Lookup Type",
    "radioItems": [
      {
        "value": "document",
        "displayValue": "Document ID",
        "help": "Look up a document by specifying the Document ID."
      },
      {
        "value": "query",
        "displayValue": "Query",
        "help": "Search the Store for a document matching the specified query criteria.  \n\u003cbr/\u003e\nIf multiple documents match, only the first result will be used."
      }
    ],
    "simpleValueType": true,
    "defaultValue": "document"
  },
  {
    "type": "TEXT",
    "name": "documentId",
    "displayName": "Document ID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "lookupType",
        "paramValue": "document",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "queryGroup",
    "displayName": "Query conditions",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "queryConditions",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Field",
            "name": "field",
            "type": "TEXT",
            "isUnique": true
          },
          {
            "defaultValue": "equal",
            "displayName": "Comparison Operator",
            "name": "operator",
            "type": "SELECT",
            "selectItems": [
              {
                "value": "equal",
                "displayValue": "\u003d\u003d"
              },
              {
                "value": "not-equal",
                "displayValue": "!\u003d"
              },
              {
                "value": "lt",
                "displayValue": "Less"
              },
              {
                "value": "lte",
                "displayValue": "Less or equal"
              },
              {
                "value": "gt",
                "displayValue": "Greater"
              },
              {
                "value": "gte",
                "displayValue": "Greater or equal"
              },
              {
                "value": "contains",
                "displayValue": "Contains"
              },
              {
                "value": "not-contains",
                "displayValue": "Not Contains"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT"
          }
        ],
        "help": "\u003ca href\u003d\"https://stape.io/helpdesk/documentation/stape-store-feature#query-operators\"\u003eLearn more about the comparison operators\u003c/a\u003e.",
        "displayName": "Query conditions"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "lookupType",
        "paramValue": "query",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "moreSettingsGroup",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "TEXT",
        "name": "documentPath",
        "displayName": "Key Path",
        "simpleValueType": true,
        "help": "The path to the desired field within the specified document. Use dot notation if needed (e.g. \u003ci\u003efoo.id\u003c/i\u003e, \u003ci\u003ebar.0.price\u003c/i\u003e).\n\u003cbr/\u003e\u003cbr/\u003e\nFor example, if the specified document is\n\u003cbr/\u003e\n\u003ci\u003e{ key1: \"value1\" }\u003c/i\u003e\n\u003cbr/\u003e\nthen a Key Path of \u003ci\u003ekey1\u003c/i\u003e will return \u003ci\u003e\"value1\"\u003c/i\u003e."
      },
      {
        "type": "CHECKBOX",
        "name": "storeResponse",
        "checkboxText": "Store the result in cache",
        "simpleValueType": true,
        "help": "Store the response in Template Storage.  \n\u003cbr/\u003e\nIf a request is made with identical parameters, the cached response (if available) will be reused instead of sending a new request."
      }
    ],
    "displayName": "More Settings"
  },
  {
    "type": "GROUP",
    "name": "stapeStoreSettingsGroup",
    "displayName": "Stape Store Settings",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "TEXT",
        "name": "stapeStoreCollectionName",
        "displayName": "Stape Store Collection Name",
        "simpleValueType": true,
        "help": "The name of the collection on the Stape Store that contains (or will contain) the document with the data.\n\u003cbr/\u003e\u003cbr/\u003e\nIf not set, the \u003ci\u003edefault\u003c/i\u003e Collection Name will be used.",
        "defaultValue": "default"
      },
      {
        "type": "SELECT",
        "name": "useDifferentStapeStore",
        "displayName": "Use the Stape Store database of a different container",
        "macrosInSelect": true,
        "selectItems": [
          {
            "value": true,
            "displayValue": "true"
          },
          {
            "value": false,
            "displayValue": "false"
          }
        ],
        "simpleValueType": true,
        "subParams": [
          {
            "type": "TEXT",
            "name": "stapeStoreContainerApiKey",
            "displayName": "Stape Store Container API Key",
            "simpleValueType": true,
            "valueHint": "euk:kzlfoobar:55ec021d429be49e64e691429cf0f27440a1b789kzlfoobar",
            "help": "If you want to interact with the Stape Store of a different container hosted on Stape, specify the \u003cb\u003eContainer API Key\u003c/b\u003e of this container.\n\u003cbr/\u003e\u003cbr/\u003e\nTo find the \u003cb\u003eContainer API Key\u003c/b\u003e, go to the \u003ca href\u003d\"https://app.eu.stape.dev/container\"\u003eStape Admin panel\u003c/a\u003e, select the sGTM container which the Stape Store you want to interact with, go to the \u003ci\u003eSettings\u003c/i\u003e tab and scroll down to the \u003ci\u003eContainer settings\u003c/i\u003e section.",
            "enablingConditions": [
              {
                "paramName": "useDifferentStapeStore",
                "paramValue": false,
                "type": "NOT_EQUALS"
              }
            ],
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "defaultValue": false
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

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


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_template_storage",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "headerWhitelist",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-gtm-identifier"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-gtm-default-domain"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "x-gtm-api-key"
                  }
                ]
              }
            ]
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

2026-05-21 Change Notes:
 - Console and BigQuery logging removal.

Created on 24/01/2024, 14:06:55

