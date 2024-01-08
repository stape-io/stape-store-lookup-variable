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
        "displayValue": "Document Path",
        "help": "Look up a document by specifying the document ID"
      },
      {
        "value": "query",
        "displayValue": "Query",
        "help": "Look up a document within a store where the document meets the specified query criteria. If multiple documents are returned from the query, only the first document is used."
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
    "name": "settings",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "TEXT",
        "name": "documentPath",
        "displayName": "Key Path",
        "simpleValueType": true,
        "help": "The path to the desired field within the specified document.\n\u003cbr\u003e\u003cbr\u003e\nFor example, if the specified document is {key1: \u0027value1\u0027}, then a Key Path of key1 will return value1."
      },
      {
        "type": "CHECKBOX",
        "name": "storeResponse",
        "checkboxText": "Store the result in cache",
        "simpleValueType": true,
        "help": "Store the query result in Template Storage. If the query parameters match an existing cache, the result will be retrieved from there."
      }
    ],
    "displayName": "More Settings"
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
  }
]


___SANDBOXED_JS_FOR_SERVER___

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
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 24/01/2024, 14:06:55


