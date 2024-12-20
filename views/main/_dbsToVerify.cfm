<cfoutput>
	<h3>App DBs required:</h3>
	<cfset prc.results[ "dbs" ] = { "errors": 0, "data": {} }>
	<ul>
		<cfloop array="#prc.settings.dbs#" item="dbg">
		<li><h4>DB Connections by #dbg.group_name#:</h4>
		<ul>
			<cfloop array="#dbg.datasources#" item="db">
				<cfif isClosure( db.datasource )>
					<cfset db.datasource = db.datasource()>
				</cfif>
				<cfif prc.settings.timersEnabled>
					<cftimer type="outline" label="#db.datasource#">
						<li>
							<cftry>
								<cfquery name="prc.#db.datasource#" datasource="#db.datasource#" timeout="5">
									SELECT top(1) #db.columnName# FROM #db.tableName#
								</cfquery>
								<b style="color:green;">#db.datasource# - Connection Successful</b>
								<cfcatch type="any">
									<b style="color:red;">#db.datasource# - Error Communicating with DB:</b> <cfdump var="#cfcatch#" expand="false">
									<cfset prc.results[ "dbs" ][ "errors" ] = prc.results[ "dbs" ][ "errors" ] + 1>
									<cfset prc.results[ "dbs" ][ "data" ][ #db.datasource# ] = { "error": "#db.datasource# - Error Communicating with DB: #cfcatch.message#" }>

									<cfif rc.loggerEnabled><cfset prc.logger[ prc.settings.loggerMethod ](
										"#prc.settings.loggerExtraInfoKey#" = cfcatch,
										"#prc.settings.loggerMessageKey#" = "#prc.settings.appName# - #controller.getSetting( "environment" )# - #server.os.hostname# - HealthCheck warning: Error connecting with #db.datasource# Datasource - required by #dbg.group_name#"
									)></cfif>
								</cfcatch>
							</cftry>
						</li>
					</cftimer>
				<cfelse>
					<li>
						<cftry>
							<cfquery name="prc.#db.datasource#" datasource="#db.datasource#" timeout="5">
								SELECT top(1) #db.columnName# FROM #db.tableName#
							</cfquery>
							<b style="color:green;">#db.datasource# - Connection Successful</b>
							<cfcatch type="any">
								<b style="color:red;">#db.datasource# - Error Communicating with DB:</b> <cfdump var="#cfcatch#" expand="false">
								<cfset prc.results[ "dbs" ][ "errors" ] = prc.results[ "dbs" ][ "errors" ] + 1>
								<cfset prc.results[ "dbs" ][ "data" ][ #db.datasource# ] = { "error": "#db.datasource# - Error Communicating with DB: #cfcatch.message#" }>

								<cfif rc.loggerEnabled><cfset prc.logger[ prc.settings.loggerMethod ](
									"#prc.settings.loggerExtraInfoKey#" = cfcatch,
									"#prc.settings.loggerMessageKey#" = "#prc.settings.appName# - #controller.getSetting( "environment" )# - #server.os.hostname# - HealthCheck warning: Error connecting with #db.datasource# Datasource - required by #dbg.group_name#"
								)></cfif>
							</cfcatch>
						</cftry>
					</li>
				</cfif>
			</cfloop>
		</ul></li>
	</cfloop>
	</ul>
</cfoutput>