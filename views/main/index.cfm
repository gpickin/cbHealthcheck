<cfoutput>
	<h1>#prc.settings.appName# Healthcheck page</h1>

	<cfinclude template="_cachesToVerify.cfm">

	<cfinclude template="_couchbaseServersToVerify.cfm">

	<cfinclude template="_dbsToVerify.cfm">

	<cfinclude template="_wireboxDslsToVerify.cfm">

	<cfinclude template="_externalSites.cfm">

	<cfparam name="prc.settings.throwOnCachesErrors" default="false">
	<cfparam name="prc.settings.throwOnCouchbaseServersErrors" default="false">
	<cfparam name="prc.settings.throwOnDBErrors" default="false">
	<cfparam name="prc.settings.throwOnServiceErrors" default="false">
	<cfparam name="prc.settings.throwOnSiteErrors" default="false">

	<cfscript>
		if( prc.settings.throwOnCachesErrors && prc.results[ "caches" ][ "errors" ] ){
			throw( type="HealthCheckException", message="HealthCheck Error: #prc.results[ "caches" ][ "errors" ]# errors found in caches", extendedInfo=serializeJSON( prc.results[ "caches" ][ "data" ] ) );
		}
		if( prc.settings.throwOnCouchbaseServersErrors && prc.results[ "couchbase_servers" ][ "errors" ] ){
			throw( type="HealthCheckException", message="HealthCheck Error: #prc.results[ "couchbase_servers" ][ "errors" ]# errors found in couchbase servers", extendedInfo=serializeJSON( prc.results[ "couchbase_servers" ][ "data" ] ) );
		}
		if( prc.settings.throwOnDBErrors && prc.results[ "dbs" ][ "errors" ] ){
			throw( type="HealthCheckException", message="HealthCheck Error: #prc.results[ "dbs" ][ "errors" ]# errors found in dbs", extendedInfo=serializeJSON( prc.results[ "dbs" ][ "data" ] ) );
		}
		if( prc.settings.throwOnServiceErrors && prc.results[ "services" ][ "errors" ] ){
			throw( type="HealthCheckException", message="HealthCheck Error: #prc.results[ "services" ][ "errors" ]# errors found in services", extendedInfo=serializeJSON( prc.results[ "services" ][ "data" ] ) );
		}
		if( prc.settings.throwOnSiteErrors && prc.results[ "sites" ][ "errors" ] ){
			throw( type="HealthCheckException", message="HealthCheck Error: #prc.results[ "sites" ][ "errors" ]# errors found in sites", extendedInfo=serializeJSON( prc.results[ "sites" ][ "data" ] ) );
		}
	</cfscript>
</cfoutput>