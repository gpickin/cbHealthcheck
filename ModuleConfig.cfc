/**
 * An Healthcheck module
 */
component {

    // Module Properties
    this.title = "cbHealthcheck";
    this.author = "Ortus Solutions";
    this.webURL = "www.ortussolutions.com";
    this.description = "Healthcheck module";
    this.version = "1.0.0";
    // If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
    this.viewParentLookup = true;
    // If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
    this.layoutParentLookup = true;
    this.parseParentSettings = true;
    // Module Entry Point
    this.entryPoint = "_healthcheck";
    // Model Namespace
    this.modelNamespace = "healthcheck";
    // CF Mapping
    this.cfmapping = "healthcheck";
    // Auto-map models
    this.autoMapModels = true;
    // Module Dependencies
    this.dependencies = [];

    function configure() {
        // module settings - stored in modules.name.settings
        settings = {
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
            cachesRequired: [],
            couchBaseServersToCheck: [],
            dbs: [ { "group_name": "Main Application", "datasources": [] } ],
            wireboxDslsToVerify: [],
            externalSites: [],
            timersEnabled: false
        };

        // Layout Settings
        layoutSettings = { defaultLayout: "" };

        // SES Routes
        routes = [
            // Module Entry Point
            // Convention Route
            { pattern: "/", handler: "main", action: "index" }
        ];

        // Custom Declared Points
        interceptorSettings = { customInterceptionPoints: "" };

        // Custom Declared Interceptors
        interceptors = [];
    }

}
