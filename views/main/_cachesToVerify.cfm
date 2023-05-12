<cfoutput>
<h3>Caches required:</h3>
<cfset prc.results[ "caches" ] = { "errors": 0, "data": {} }>
<ul>
	<cfloop array="#prc.settings.cachesRequired#" item="cacheItem">
		<li>#cacheItem.cacheName# -
			<cftry>
				<cfset prc[ "cache_#cacheItem.cacheName#" ] = controller.getCache( cacheItem.cacheName )>
				<cfset prc[ "#cacheItem.testVariableName#_seed" ] = {name=cacheItem.testValue, awesome=true, cacheWeirdo=true}>
				<cfset prc[ "cache_#cacheItem.cacheName#" ].set("MyValue#cacheItem.cacheName#", prc[ "#cacheItem.testVariableName#_seed" ], 60,20)>
				<cfset prc[ cacheItem.testVariableName ] = prc[ "cache_#cacheItem.cacheName#" ].get( "MyValue#cacheItem.cacheName#" )>
				<cfif prc[ cacheItem.testVariableName ].name eq prc[ "#cacheItem.testVariableName#_seed" ].name>
					<b style="color:green;">Cache returned correct values</b>
				<cfelse>
					<b style="color:red;">Cache returned wrong values - Expected [#prc[ cacheItem.testVariableName ].name#] and received [#prc[ "#cacheItem.testVariableName#_seed" ].name#]</b>
					<cfset prc.results[ "caches" ][ "errors" ] = prc.results[ "caches" ][ "errors" ] + 1>
					<cfset prc.results[ "caches" ][ "data" ][ cacheItem.cacheName ] = { "error": "Cache returned wrong values - Expected [#prc[ cacheItem.testVariableName ].name#] and received [#prc[ "#cacheItem.testVariableName#_seed" ].name#]" }>
				</cfif>
				<cfcatch type="any">
					<b style="color:red;">Error Communicating</b> with Cache: <cfdump var="#cfcatch#" expand="false">

					<cfset prc.results[ "caches" ][ "errors" ] = prc.results[ "caches" ][ "errors" ] + 1>
					<cfset prc.results[ "caches" ][ "data" ][ cacheItem.cacheName ] = { "error": "Error Communicating</b> with Cache: #cfcatch.message#" }>
					<cfif rc.loggerEnabled><cfset prc.logger[ prc.settings.loggerMethod ](
						"#prc.settings.loggerExtraInfoKey#" = cfcatch,
						"#prc.settings.loggerMessageKey#" = "#prc.settings.appName# - #controller.getSetting( "environment" )# - #server.os.hostname# - HealthCheck warning: Error communicating with #cacheItem.cacheName# cache"
					)></cfif>
				</cfcatch>
			</cftry>
		</li>
	</cfloop>
</ul>
</cfoutput>