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
        "displayName": "Query conditions",
        "newRowButtonText": "Add condition"
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
        "displayName": "Property To Return",
        "simpleValueType": true,
        "help": "The path to the desired property within the specified document to be returned by the variable. Leave blank to return the whole document.\n\u003cbr/\u003e\u003cbr/\u003e\nUse dot notation if needed (e.g. \u003ci\u003efoo.id\u003c/i\u003e, \u003ci\u003ebar.0.price\u003c/i\u003e).\n\u003cbr/\u003e\nFor example, if the specified document is\n\u003cbr/\u003e\n\u003ci\u003e{ key1: \"value1\" }\u003c/i\u003e\n\u003cbr/\u003e\nthen a Key Path of \u003ci\u003ekey1\u003c/i\u003e will return \u003ci\u003e\"value1\"\u003c/i\u003e.",
        "valueHint": "bar.0.price"
      },
      {
        "type": "CHECKBOX",
        "name": "storeResponse",
        "checkboxText": "Store the result in cache",
        "simpleValueType": true,
        "help": "Store the response in Template Storage.  \n\u003cbr/\u003e\nIf a request is made with identical parameters, the cached response (if available) will be reused instead of sending a new request.",
        "subParams": [
          {
            "type": "TEXT",
            "name": "cacheExpirationTime",
            "displayName": "Cache Expiration Time",
            "simpleValueType": true,
            "defaultValue": 180,
            "enablingConditions": [
              {
                "paramName": "storeResponse",
                "paramValue": true,
                "type": "EQUALS"
              }
            ],
            "help": "Defines how long data stays in cache before being retrieved again from the Stape Store.",
            "valueValidators": [
              {
                "type": "POSITIVE_NUMBER"
              }
            ],
            "valueUnit": "minutes"
          }
        ]
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
const getTimestampMillis = require('getTimestampMillis');
const getType = require('getType');
const JSON = require('JSON');
const makeInteger = require('makeInteger');
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

function generateRequestUrl(data) {
  const storeBaseUrl = getStapeStoreBaseUrl(data);
  if (data.lookupType === 'document') return storeBaseUrl + '/' + enc(data.documentId);
  return storeBaseUrl;
}

function generateRequestOptions(data) {
  const optionsByLookupType = {
    document: { method: 'GET' },
    query: { method: 'POST', headers: { 'Content-Type': 'application/json' } }
  };

  return optionsByLookupType[data.lookupType];
}

function generateQueryLookupBody(data) {
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
  const url = generateRequestUrl(data);
  const options = generateRequestOptions(data);
  const body = data.lookupType === 'query' ? generateQueryLookupBody(data) : undefined;
  const bodyStrigified = body ? JSON.stringify(body) : undefined;
  const cacheKey = data.storeResponse ? sha256Sync(url + (bodyStrigified || '')) : undefined;

  if (data.storeResponse) {
    const cachedValue = templateDataStorage.getItemCopy(cacheKey);
    if (
      getType(cachedValue) === 'object' &&
      cachedValue.resultBodyString &&
      cachedValue.expiresAt
    ) {
      if (getTimestampMillis() < cachedValue.expiresAt) {
        return Promise.create((resolve) => resolve(cachedValue.resultBodyString));
      }
    }
  }

  return sendHttpRequest(url, options, bodyStrigified)
    .then((result) => {
      const resultBodyString = result.body;
      const parsedBody = JSON.parse(resultBodyString || '{}');
      if (result.statusCode === 200 && parsedBody.success) {
        if (data.storeResponse) {
          templateDataStorage.setItemCopy(cacheKey, {
            resultBodyString: resultBodyString,
            expiresAt:
              getTimestampMillis() + makeInteger(data.cacheExpirationTime || 180) * 60 * 1000
          });
        }
        return resultBodyString;
      } else {
        return null;
      }
    })
    .catch(() => {
      return null;
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

scenarios:
- name: '[Early Exit] Document lookup without a Document ID returns null and does
    not send a request'
  code: |-
    const copyMockData = setAllMockData({ documentId: undefined });

    const variableResult = runCode(copyMockData);

    assertApi('sendHttpRequest').wasNotCalled();
    assertThat(variableResult).isNull();
- name: '[Document Lookup] Sends a GET request to the correct URL built from request
    headers'
  code: |-
    const copyMockData = setAllMockData();

    mock('sendHttpRequest', (url, options, body) => {
      assertThat(url).isEqualTo(EXPECTED_BASE_URL + '/doc123');
      assertThat(options).isEqualTo({ method: 'GET' });
      assertThat(body).isUndefined();
      return Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ data: {} }) }));
    });

    runCode(copyMockData);

    assertApi('sendHttpRequest').wasCalled();
- name: '[Document Lookup] Uses a custom Stape Store Collection Name in the URL when
    provided'
  code: |-
    const copyMockData = setAllMockData({ stapeStoreCollectionName: 'customCollection' });

    mock('sendHttpRequest', (url) => {
      assertThat(url).isEqualTo('https://expectedXGtmIdentifier.expectedXGtmDefaultDomain/stape-api/expectedXGtmApiKey/v2/store/collections/customCollection/documents/doc123');
      return Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ data: {} }) }));
    });

    runCode(copyMockData);

    assertApi('sendHttpRequest').wasCalled();
- name: '[Different Stape Store] Builds the URL using the provided Container API Key
    parts'
  code: |-
    [true, 'true'].forEach((flagValue) => {
      const copyMockData = setAllMockData({
        useDifferentStapeStore: flagValue,
        stapeStoreContainerApiKey: 'eu:myContainer:myApiKey:io'
      });

      mock('sendHttpRequest', (url) => {
        assertThat(url).isEqualTo('https://myContainer.eu.stape.io/stape-api/myApiKey/v2/store/collections/default/documents/doc123');
        return Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ data: {} }) }));
      });

      runCode(copyMockData);
    });

    assertApi('sendHttpRequest').wasCalled();
- name: '[Different Stape Store] Falls back to default region io when Container API
    Key has no region part'
  code: |-
    const copyMockData = setAllMockData({
      useDifferentStapeStore: true,
      stapeStoreContainerApiKey: 'eu:myContainer:myApiKey'
    });

    mock('sendHttpRequest', (url) => {
      assertThat(url).isEqualTo('https://myContainer.eu.stape.io/stape-api/myApiKey/v2/store/collections/default/documents/doc123');
      return Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ data: {} }) }));
    });

    runCode(copyMockData);

    assertApi('sendHttpRequest').wasCalled();
- name: '[Different Stape Store] Falls back to request headers when Container API
    Key is not a valid string'
  code: |-
    [undefined, 123].forEach((invalidApiKey) => {
      const copyMockData = setAllMockData({
        useDifferentStapeStore: true,
        stapeStoreContainerApiKey: invalidApiKey
      });

      mock('sendHttpRequest', (url) => {
        assertThat(url).isEqualTo(EXPECTED_BASE_URL + '/doc123');
        return Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ data: {} }) }));
      });

      runCode(copyMockData);
    });

    assertApi('sendHttpRequest').wasCalled();
- name: '[Query Lookup] Sends a POST request with URL, headers and body built from
    Query Conditions'
  code: |-
    const copyMockData = setAllMockData({
      lookupType: 'query',
      documentId: undefined,
      queryConditions: [
        { field: 'foo', operator: 'equal', value: 'bar' },
        { field: 'baz', operator: 'gt', value: '1' }
      ]
    });

    mock('sendHttpRequest', (url, options, body) => {
      assertThat(url).isEqualTo(EXPECTED_BASE_URL);
      assertThat(options).isEqualTo({ method: 'POST', headers: { 'Content-Type': 'application/json' } });
      assertThat(body).isEqualTo(JSON.stringify({
        filter: {
          operator: 'and',
          conditions: [
            { field: 'foo', operator: 'equal', value: 'bar' },
            { field: 'baz', operator: 'gt', value: '1' }
          ]
        },
        pagination: { limit: 1 }
      }));
      return Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ items: [] }) }));
    });

    runCode(copyMockData);

    assertApi('sendHttpRequest').wasCalled();
- name: '[Query Lookup] Sends an empty conditions filter when no Query Conditions
    are provided'
  code: |-
    const copyMockData = setAllMockData({ lookupType: 'query', documentId: undefined, queryConditions: undefined });

    mock('sendHttpRequest', (url, options, body) => {
      assertThat(body).isEqualTo(JSON.stringify({
        filter: { operator: 'and', conditions: [] },
        pagination: { limit: 1 }
      }));
      return Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ items: [] }) }));
    });

    runCode(copyMockData);

    assertApi('sendHttpRequest').wasCalled();
- name: '[Response Mapping] Returns the whole document data when Property To Return
    is empty'
  code: |-
    const copyMockData = setAllMockData({ documentPath: '' });

    mock('sendHttpRequest', () => {
      return Promise.create((resolve) => resolve({
        statusCode: 200,
        body: buildSuccessBody({ id: 'doc123', data: { key1: 'value1', nested: { a: 1 } } })
      }));
    });

    runCode(copyMockData).then((variableResult) => {
      assertThat(variableResult).isEqualTo({ key1: 'value1', nested: { a: 1 } });
    });
- name: '[Response Mapping] Returns nested value using dot notation or undefined when
    the path does not exist'
  code: |-
    [
      { documentPath: 'nested.a', expected: 1 },
      { documentPath: 'foo.bar', expected: undefined }
    ].forEach((scenario) => {
      const copyMockData = setAllMockData({ documentPath: scenario.documentPath });

      mock('sendHttpRequest', () => {
        return Promise.create((resolve) => resolve({
          statusCode: 200,
          body: buildSuccessBody({ data: { key1: 'value1', nested: { a: 1 } } })
        }));
      });

      runCode(copyMockData).then((variableResult) => {
        if (getType(scenario.expected) === 'undefined') {
          assertThat(variableResult).isUndefined();
        } else {
          assertThat(variableResult).isEqualTo(scenario.expected);
        }
      });
    });
- name: '[Response Mapping] Uses the first item from the Query Lookup results'
  code: |-
    const copyMockData = setAllMockData({ lookupType: 'query', documentId: undefined, documentPath: 'k' });

    mock('sendHttpRequest', () => {
      return Promise.create((resolve) => resolve({
        statusCode: 200,
        body: buildSuccessBody({ items: [{ id: 'd1', data: { k: 'v1' } }, { id: 'd2', data: { k: 'v2' } }] })
      }));
    });

    runCode(copyMockData).then((variableResult) => {
      assertThat(variableResult).isEqualTo('v1');
    });
- name: '[Response Mapping] Returns an empty object when the Query Lookup finds no
    matching items'
  code: |-
    [
      { items: [] },
      { items: undefined },
      { items: ['not-an-object'] }
    ].forEach((scenario) => {
      const copyMockData = setAllMockData({ lookupType: 'query', documentId: undefined, documentPath: '' });

      mock('sendHttpRequest', () => {
        return Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody(scenario) }));
      });

      runCode(copyMockData).then((variableResult) => {
        assertThat(variableResult).isEqualTo({});
      });
    });
- name: '[Failure] Returns an empty object when the response is unsuccessful, the
    status code is not 200, or the request fails'
  code: |-
    [
      { description: 'success is false', mockResponse: () => Promise.create((resolve) => resolve({ statusCode: 200, body: JSON.stringify({ success: false }) })) },
      { description: 'status code is not 200', mockResponse: () => Promise.create((resolve) => resolve({ statusCode: 404, body: buildSuccessBody({ data: { key1: 'value1' } }) })) },
      { description: 'request fails or times out', mockResponse: () => Promise.create((resolve, reject) => reject({ reason: 'timed out' })) }
    ].forEach((scenario) => {
      const copyMockData = setAllMockData();

      mock('sendHttpRequest', scenario.mockResponse);

      runCode(copyMockData).then((variableResult) => {
        assertThat(variableResult).isEqualTo({});
      });
    });
- name: '[Response Mapping] Returns undefined when Property To Return is set but the
    document was not found or the property does not exist in it'
  code: |-
    [
      { description: 'document does not exist (success is false)', mockResponse: () => Promise.create((resolve) => resolve({ statusCode: 200, body: JSON.stringify({ success: false }) })) },
      { description: 'document does not exist (status code is not 200)', mockResponse: () => Promise.create((resolve) => resolve({ statusCode: 404, body: buildSuccessBody({ data: { key1: 'value1' } }) })) },
      { description: 'document does not exist (request fails or times out)', mockResponse: () => Promise.create((resolve, reject) => reject({ reason: 'timed out' })) },
      { description: 'document exists but the property is missing', mockResponse: () => Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ data: { key1: 'value1' } }) })) }
    ].forEach((scenario) => {
      const copyMockData = setAllMockData({ documentPath: 'foo.bar' });

      mock('sendHttpRequest', scenario.mockResponse);

      runCode(copyMockData).then((variableResult) => {
        assertThat(variableResult).isUndefined();
      });
    });
- name: '[Cache] Does not interact with the cache when storing the result in cache
    is disabled'
  code: |-
    const copyMockData = setAllMockData({ storeResponse: false });

    let getItemCopyWasCalled = false;
    let setItemCopyWasCalled = false;
    mockObject('templateDataStorage', {
      getItemCopy: () => { getItemCopyWasCalled = true; },
      setItemCopy: () => { setItemCopyWasCalled = true; }
    });

    mock('sendHttpRequest', () => Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ data: {} }) })));

    runCode(copyMockData);

    callLater(() => {
      assertThat(getItemCopyWasCalled).isFalse();
      assertThat(setItemCopyWasCalled).isFalse();
      assertApi('sendHttpRequest').wasCalled();
    });
- name: '[Cache] Sends a request and stores the response in cache when the cache is
    empty'
  code: |-
    const copyMockData = setAllMockData({ storeResponse: true, cacheExpirationTime: '5' });

    const EXPECTED_CACHE_KEY = 'HASH:' + EXPECTED_BASE_URL + '/doc123';
    const responseBody = buildSuccessBody({ data: {} });

    let getItemCopyWasCalled = false;
    let setItemCopyWasCalled = false;
    mockObject('templateDataStorage', {
      getItemCopy: (key) => {
        getItemCopyWasCalled = true;
        assertThat(key).isEqualTo(EXPECTED_CACHE_KEY);
        return undefined;
      },
      setItemCopy: (key, value) => {
        setItemCopyWasCalled = true;
        assertThat(key).isEqualTo(EXPECTED_CACHE_KEY);
        assertThat(value).isEqualTo({ resultBodyString: responseBody, expiresAt: NOW + 5 * 60 * 1000 });
      }
    });

    mock('sendHttpRequest', () => Promise.create((resolve) => resolve({ statusCode: 200, body: responseBody })));

    runCode(copyMockData);

    callLater(() => {
      assertThat(getItemCopyWasCalled).isTrue();
      assertThat(setItemCopyWasCalled).isTrue();
    });
- name: '[Cache] Reuses the cached response without sending a new request when the
    cache is still valid'
  code: |-
    const copyMockData = setAllMockData({ storeResponse: true, documentPath: '' });

    const cachedDocumentData = { key1: 'cachedValue' };
    const cachedResultBodyString = buildSuccessBody({ data: cachedDocumentData });

    let setItemCopyWasCalled = false;
    mockObject('templateDataStorage', {
      getItemCopy: () => {
        return { resultBodyString: cachedResultBodyString, expiresAt: NOW + 1000 };
      },
      setItemCopy: () => { setItemCopyWasCalled = true; }
    });

    runCode(copyMockData).then((variableResult) => {
      assertThat(variableResult).isEqualTo(cachedDocumentData);
    });

    callLater(() => {
      assertThat(setItemCopyWasCalled).isFalse();
      assertApi('sendHttpRequest').wasNotCalled();
    });
- name: '[Cache] Sends a new request and updates the cache when the cached response
    has expired'
  code: |-
    const copyMockData = setAllMockData({ storeResponse: true });

    const responseBody = buildSuccessBody({ data: {} });

    let setItemCopyWasCalled = false;
    mockObject('templateDataStorage', {
      getItemCopy: () => {
        return { resultBodyString: 'stale', expiresAt: NOW - 1 };
      },
      setItemCopy: () => { setItemCopyWasCalled = true; }
    });

    mock('sendHttpRequest', () => Promise.create((resolve) => resolve({ statusCode: 200, body: responseBody })));

    runCode(copyMockData);

    callLater(() => {
      assertThat(setItemCopyWasCalled).isTrue();
      assertApi('sendHttpRequest').wasCalled();
    });
- name: '[Cache] Sends a new request when the cached value has an invalid shape'
  code: |-
    [
      { description: 'missing resultBodyString', cachedValue: { expiresAt: NOW + 1000 } },
      { description: 'missing expiresAt', cachedValue: { resultBodyString: 'x' } },
      { description: 'not an object', cachedValue: 'invalid' }
    ].forEach((scenario) => {
      const copyMockData = setAllMockData({ storeResponse: true });

      mockObject('templateDataStorage', {
        getItemCopy: () => scenario.cachedValue,
        setItemCopy: () => {}
      });

      mock('sendHttpRequest', () => Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ data: {} }) })));

      runCode(copyMockData);
    });

    callLater(() => {
      assertApi('sendHttpRequest').wasCalled();
    });
- name: '[Cache] Falls back to the default 180 minute expiration when Cache Expiration
    Time is not provided'
  code: |-
    const copyMockData = setAllMockData({ storeResponse: true, cacheExpirationTime: undefined });

    let cachedExpiresAt;
    mockObject('templateDataStorage', {
      getItemCopy: () => undefined,
      setItemCopy: (key, value) => { cachedExpiresAt = value.expiresAt; }
    });

    mock('sendHttpRequest', () => Promise.create((resolve) => resolve({ statusCode: 200, body: buildSuccessBody({ data: {} }) })));

    runCode(copyMockData);

    callLater(() => {
      assertThat(cachedExpiresAt).isEqualTo(NOW + 180 * 60 * 1000);
    });
setup: |-
  const JSON = require('JSON');
  const Promise = require('Promise');
  const callLater = require('callLater');
  const getType = require('getType');

  const assign = () => {
    const target = arguments[0];
    for (let i = 1; i < arguments.length; i++) {
      for (let key in arguments[i]) {
        target[key] = arguments[i][key];
      }
    }
    return target;
  };

  mock('getRequestHeader', (header) => {
    if (header === 'x-gtm-identifier') return 'expectedXGtmIdentifier';
    else if (header === 'x-gtm-default-domain') return 'expectedXGtmDefaultDomain';
    else if (header === 'x-gtm-api-key') return 'expectedXGtmApiKey';
  });

  mock('sha256Sync', (str) => 'HASH:' + str);

  const NOW = 1747945830456;
  mock('getTimestampMillis', NOW);

  const EXPECTED_BASE_URL = 'https://expectedXGtmIdentifier.expectedXGtmDefaultDomain/stape-api/expectedXGtmApiKey/v2/store/collections/default/documents';

  const buildSuccessBody = (dataPayload) => JSON.stringify({ success: true, data: dataPayload });

  const mockData = {
    lookupType: 'document',
    documentId: 'doc123',
    documentPath: '',
    storeResponse: false,
    cacheExpirationTime: '180',
    stapeStoreCollectionName: 'default',
    useDifferentStapeStore: false
  };

  const setAllMockData = (objToBeMerged) => {
    return assign(JSON.parse(JSON.stringify(mockData)), objToBeMerged || {});
  };


___NOTES___

2026-07-20 Change Notes:
 - Simplify response handling by letting mapResponse return the fallback value directly, removing the redundant ternary wrapper around lookupInStore's result.
 - Add unit tests covering document/query lookup requests, different Stape Store configuration, response mapping (including missing documents/properties), failure handling, and the cache lifecycle.

2026-07-02 Change Notes:
 - Add cache expiration and improve cache mechanism.

2026-05-21 Change Notes:
 - Console and BigQuery logging removal.

Created on 24/01/2024, 14:06:55

