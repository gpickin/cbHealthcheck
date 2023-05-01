/**
 * Main Handler
 */
component {

	property name="settings" inject="coldbox:modulesettings:cbHealthcheck";

	/**
	 * index
	 */
	function index( event, rc, prc ) {
		setting requesttimeout="90";
		prc.results = {};
		prc.settings = settings;
		param rc.loggerEnabled = settings.loggerEnabled;
		prc.logger = getInstance( prc.settings.logger );
		event.noLayout();
	}

}
