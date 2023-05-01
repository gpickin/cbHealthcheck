<cfoutput>
	<h3>Wirebox DSLs to Verify</h3>
	<cfset prc.results[ "services" ] = { "errors": 0, "data": {} }>
	<ul>
		<cfloop array="#prc.settings.wireboxDslsToVerify#" item="service">
			<cfparam name="service.required" default="true">
			<cftry>
				<cfset variables[ listFirst( service.dsl, "@") ] = getInstance( service.dsl )>
				<cfset metaData = getMetadata( variables[ listFirst( service.dsl, "@") ] )>
				<cfif structKeyExists( metaData, "type" )>
					<cfset type = metaData.type>
				<cfelse>
					<cfset type = listLast( metaData, "." )>
				</cfif>

				<cfif service.type eq type && !service.required>
					<li><b style="color:green;">#service.dsl# - Creation Successful</b></li>
				<cfelseif service.type eq type && ( service.required && !isEmpty( variables[ listFirst( service.dsl, "@") ] ) )>
					<li><b style="color:green;">#service.dsl# - Creation Successful &amp; Value not Empty</b></li>
				<cfelseif service.type eq type && ( service.required )>
					<li>
						<b style="color:red;">
							#service.dsl# - Error Creating Service: Received #type# but was empty
						</b>
					</li>
					<cfset prc.results[ "services" ][ "errors" ] = prc.results[ "services" ][ "errors" ] + 1>
					<cfset prc.results[ "services" ][ "data" ][ service.dsl ] = { "error": "Error with Service: #service.dsl# - Received type #type# but was empty" }>
				<cfelse>
					<li>
						<b style="color:red;">
							#service.dsl# - Error Creating Service: returned #type#
						</b>
					</li>
					<cfset prc.results[ "services" ][ "errors" ] = prc.results[ "services" ][ "errors" ] + 1>
					<cfset prc.results[ "services" ][ "data" ][ service.dsl ] = { "error": "Error with Service: #service.dsl# - Expected type #service.type# and received type #type#" }>
				</cfif>
				<cfcatch type="any">
					<li><b style="color:red;">#service.dsl# - Error Creating Service: </b> <cfdump var="#cfcatch#" expand="false"></li>
					<cfset prc.results[ "services" ][ "errors" ] = prc.results[ "services" ][ "errors" ] + 1>
					<cfset prc.results[ "services" ][ "data" ][ listFirst( service.dsl, "@") ] = { "error": "Error creating Service: #service.dsl# - #cfcatch.message#" }>
					<cfif rc.loggerEnabled><cfset prc.logger[ prc.settings.loggerMethod ](
						prc.settings.loggerExtraInfoKey = cfcatch,
						prc.settings.loggerMessageKey = "#prc.settings.appName# - #controller.getSetting( "environment" )# - #server.os.hostname# - HealthCheck Error: Error creating Service #service.dsl# - #cfcatch.message#"
					)></cfif>
				</cfcatch>
			</cftry>
		</cfloop>
	</ul>
</cfoutput>