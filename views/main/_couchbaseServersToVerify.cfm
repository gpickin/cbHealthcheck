<cfoutput>
<h3>Couchbase Servers</h3>
<cfset prc.results[ "couchbase_servers" ] = { "errors": 0, "data": {} }>
<cfset prc.settings.couchBaseServersToCheck = listToArray( listRemoveDuplicates( arrayToList( prc.settings.couchBaseServersToCheck ) ) )>
<cfif len( prc.settings.couchBaseServersToCheck )>
	<ul>
		<cfloop array="#prc.settings.couchBaseServersToCheck#" item="couchBase">
			<cfhttp result="result" method="GET" charset="utf-8" url="#couchBase#" timeout="5">
			</cfhttp>
			
			<cfif result.status_code eq 200>
				<li><b style="color:green;">CouchBase Server: #couchBase# - Connection Successful: #result.statuscode#</b></li>
			<cfelse>
				<li><b style="color:red;">CouchBase Server: #couchBase# - Connection Failed: #result.statuscode#</b> <cfif structKeyExists( result, "errordetail" )> - #result.errordetail#</cfif>
					<br>File Content: <textarea onFocus="select()" style="width:100%">#result.fileContent#</textarea></li>
				<cfset prc.results[ "couchbase_servers" ][ "errors" ] = prc.results[ "couchbase_servers" ][ "errors" ] + 1>
				<cfset prc.results[ "couchbase_servers" ][ "data" ][ couchBase ] = { "error": "CouchBase Server: #couchBase# - Connection Failed: #result.statuscode# - #result?.errordetail#" }>
				<cfif rc.loggerEnabled><cfset prc.logger[ prc.settings.loggerMethod ](
					prc.settings.loggerExtraInfoKey = result,
					prc.settings.loggerMessageKey = "#prc.settings.appName# - #controller.getSetting( "environment" )# - #server.os.hostname# - HealthCheck warning: Error Connecting to Couchbase Server: #couchBase# - #result.statuscode# #result?.errordetail# - File Content #result.fileContent#"
				)></cfif>
			</cfif>
		</cfloop>
	</ul>
<cfelse>
	<p><b style="color:red;">No CouchBase Servers to check</b></p>
</cfif>
</cfoutput>