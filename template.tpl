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
  "displayName": "dataLayer fields value validate",
  "description": "Validates the quality of the data layer object by identifying and returning a list of fields containing null, undefined, or empty values.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const queryPermission = require('queryPermission');
const copyFromWindow = require('copyFromWindow');
const logToConsole = require('logToConsole');
const Object = require('Object');
let dataLayerCopy;

if(queryPermission('access_globals', 'read', 'dataLayer')) {
  dataLayerCopy = copyFromWindow('dataLayer');
} else {
  data.gtmOnFailure();
}


if (typeof dataLayerCopy == 'object') {
  let nullUndefinedOrEmptyPaths = findNullUndefinedOrEmptyPaths(dataLayerCopy,[]);
  if (nullUndefinedOrEmptyPaths.length > 1) {
    return nullUndefinedOrEmptyPaths;
  }
  return false;
} else {
  return false;
}

function findNullUndefinedOrEmptyPaths(obj, path) {
  const nullUndefinedOrEmptyPaths = [];
  for (let key in obj) {
    const value = obj[key];
    const newPath = [key].concat(path);
    if (value === null || value === undefined || value === '') {
      nullUndefinedOrEmptyPaths.push(newPath.join('.'));
    } else if (typeof value === 'object' && value !== null) {
      nullUndefinedOrEmptyPaths.push(findNullUndefinedOrEmptyPaths(value, newPath));
    }
  }
  return nullUndefinedOrEmptyPaths;
}


___WEB_PERMISSIONS___

[
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
            "string": "debug"
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
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
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
setup: |-
  const dataLayer={
    a: 1,
    b: null,
    c: {
      d: 'hello',
      e: undefined,
      f: {
        g: ''
      }
    }
  };


___NOTES___

Created on 12/2/2024, 11:23:39 PM


