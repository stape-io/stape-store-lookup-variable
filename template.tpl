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
  "description": "The value is set to the value from a key in a Stape Store document.",
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
        "help": "\u003ca href\u003d\"https://postgrest.org/en/stable/references/api/tables_views.html#horizontal-filtering\"\u003eRead more\u003c/a\u003e"
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
        "help": "The path to the desired field within the specified document.\n\u003cbr/\u003e\u003cbr/\u003e\nFor example, if the specified document is\n\u003cbr/\u003e\n\u003ci\u003e{ key1: \"value1\" }\u003c/i\u003e\n\u003cbr/\u003e\nthen a Key Path of \u003ci\u003ekey1\u003c/i\u003e will return \u003ci\u003e\"value1\"\u003c/i\u003e."
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
        "help": "The name of the collection on the Stape Store that contains (or will contain) the document with the data.\n\u003cbr/\u003e\u003cbr/\u003e\nIf not set, the \u003ci\u003edefault\u003c/i\u003e Collection Name will be used."
      }
    ]
  },
  {
    "displayName": "Logs Settings",
    "name": "logsGroup",
    "groupStyle": "ZIPPY_CLOSED",
    "type": "GROUP",
    "subParams": [
      {
        "type": "RADIO",
        "name": "logType",
        "radioItems": [
          {
            "value": "no",
            "displayValue": "Do not log"
          },
          {
            "value": "debug",
            "displayValue": "Log to console during debug and preview"
          },
          {
            "value": "always",
            "displayValue": "Always log to console"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "debug"
      }
    ]
  },
  {
    "displayName": "BigQuery Logs Settings",
    "name": "bigQueryLogsGroup",
    "groupStyle": "ZIPPY_CLOSED",
    "type": "GROUP",
    "subParams": [
      {
        "type": "RADIO",
        "name": "bigQueryLogType",
        "radioItems": [
          {
            "value": "no",
            "displayValue": "Do not log to BigQuery"
          },
          {
            "value": "always",
            "displayValue": "Log to BigQuery"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "no"
      },
      {
        "type": "GROUP",
        "name": "logsBigQueryConfigGroup",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "TEXT",
            "name": "logBigQueryProjectId",
            "displayName": "BigQuery Project ID",
            "simpleValueType": true,
            "help": "Optional.  \u003cbr/\u003e\u003cbr/\u003e  If omitted, it will be retrieved from the environment variable \u003cI\u003eGOOGLE_CLOUD_PROJECT\u003c/i\u003e where the server container is running. If the server container is running on Google Cloud, \u003cI\u003eGOOGLE_CLOUD_PROJECT\u003c/i\u003e will already be set to the Google Cloud project\u0027s ID."
          },
          {
            "type": "TEXT",
            "name": "logBigQueryDatasetId",
            "displayName": "BigQuery Dataset ID",
            "simpleValueType": true,
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "type": "TEXT",
            "name": "logBigQueryTableId",
            "displayName": "BigQuery Table ID",
            "simpleValueType": true,
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "enablingConditions": [
          {
            "paramName": "bigQueryLogType",
            "paramValue": "always",
            "type": "EQUALS"
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

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

function getStapeStoreBaseUrl(data) {
  const containerIdentifier = getRequestHeader('x-gtm-identifier');
  const defaultDomain = getRequestHeader('x-gtm-default-domain');
  const containerApiKey = getRequestHeader('x-gtm-api-key');
  const collectionPath =
    'collections/' + enc(data.stapeStoreCollectionName || 'default') + '/documents';

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
                    "string": "trace-id"
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
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
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
        "publicId": "read_container_data",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_bigquery",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedTables",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "projectId"
                  },
                  {
                    "type": 1,
                    "string": "datasetId"
                  },
                  {
                    "type": 1,
                    "string": "tableId"
                  },
                  {
                    "type": 1,
                    "string": "operation"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ]
              }
            ]
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

Created on 24/01/2024, 14:06:55


