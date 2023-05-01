# cbHealthcheck

A easy to use Healthcheck module

## Functionality

By default, the Healthcheck logs all fails for all sections. Once that is complete, it will check which categories of errors you would throw for, and then if one of those has errors, it will throw that error and fail the healthcheck.

### Logging / Reporting Issues

The module will report any error using the Logger selected (if you enable it).

#### Configuring Logger

The default logger is Sentry. You can change the wirebox mapping for the Logger by changing the `logger` setting in your configuration. You can also set the method for calling on your logger, and the message key and extra info.

The default is sentry

```
logger: "SentryService@sentry",
loggerMethod: "captureException",
loggerMessageKey: "message",
loggerExtraInfoKey: "exception",
```

If you wanted to use a logbox logger, you could use the following

```
logger: "logbox:logger:{this}",
loggerMethod: "warn",
loggerMessageKey: "message",
loggerExtraInfoKey: "extraInfo",
```

#### Disabling the Logger

- URL param `loggerEnabled=0` to disable on a call by call basis
- Set the `loggerEnabled` setting in your ColdBox config.

### What causes the healthcheck to fail?

Healthcheck only fails if you have 1 or more Errors in one of the categories, you have selected to throw / fail the healthcheck for.

```
throwOnCachesErrors: false,
throwOnCouchbaseServersErrors: false,
throwOnDBErrors: false,
throwOnServiceErrors: true,
throwOnSiteErrors: false,
```

## Types of items to check for Health

- cachesRequired
- couchBaseServersToCheck
- dbs
- wireboxDslsToVerify
- externalSites

## Configuration

### Example Configuration

```
appName: "Gavin's Blog",
logger: "SentryService@sentry",
loggerEnabled: true,
loggerMethod: "captureException",
loggerMessageKey: "message",
loggerExtraInfoKey: "exception",
throwOnCachesErrors: false,
throwOnCouchbaseServersErrors: false,
throwOnDBErrors: false,
throwOnServiceErrors: true,
throwOnSiteErrors: false,
cachesRequired = [
    { cacheName: "template", testVariableName: "TemplateTestValue", testValue: "Brad Wood" },
    { cacheName: "session", testVariableName: "SessionTestValue", testValue: "Gavin Pickin" }
],
couchBaseServersToCheck: [
    "127.0.0.100",
    "127.0.0.101",
],
dbs: [
    {
        "group_name": "Main Application",
        "datasources": [
            { datasource: "applicationDB", columnName: "id", tableName: "users" }
            { datasource: "loggingDB", columnName: "id", tableName: "email_logs" }
            { datasource: "backupDB", columnName: "id", tableName: "users" }
        ]
    }
],
wireboxDslsToVerify: [
    { "dsl": "quickService:user@core", "type": "component" },
    { "dsl": "UnleashSDK@unleashsdk", "type": "component" },
    { "dsl": "JwtService@cbsecurity", "type": "component" },
    { "dsl": "cbSecurity@cbSecurity", "type": "component" },
    { "dsl": "FirebaseService@apiv1", "type": "component" },
    { "dsl": "coldbox:setting:firebasePrivateKey", "type": "String", "required": true },
    { "dsl": "coldbox:setting:firebaseScope", "type": "String", "required": true },
    { "dsl": "coldbox:setting:apiRateLimit", "type": "Double", "required": true }
],
externalSites: []
```

### Base Config

```
appName: "Unknown App",
logger: "SentryService@sentry",
loggerEnabled: true,
loggerMethod: "captureException",
loggerMessageKey: "message",
loggerExtraInfoKey: "exception",
throwOnCachesErrors: false,
throwOnCouchbaseServersErrors: false,
throwOnDBErrors: false,
throwOnServiceErrors: true,
throwOnSiteErrors: false,
cachesRequired = [],
couchBaseServersToCheck: [],
dbs: [
    {
        "group_name": "Main Application",
        "datasources": []
    }
],
wireboxDslsToVerify: [],
externalSites: []
```
