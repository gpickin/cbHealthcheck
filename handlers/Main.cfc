/**
 * Main Handler
 */
component {

    property name="settings" inject="coldbox:modulesettings:cbHealthcheck";

    // this code returns the request timeout for the current request
    // the request timeout is the number of seconds that the server will wait for a request
    // to complete before timing out the request
    // the function returns the request timeout, in seconds
    function getTimeout() {
        // create an object of type coldfusion.runtime.RequestMonitor
        var requestMonitor = createObject( "java", "coldfusion.runtime.RequestMonitor" );
        // call the getRequestTimeout() method on the RequestMonitor object
        return requestMonitor.getRequestTimeout();
    }

    /**
     * index
     */
    function index( event, rc, prc ) {
        setting requesttimeout=getTimeout() + 30;
        prc.results = {};
        prc.settings = settings;
        param rc.loggerEnabled = settings.loggerEnabled;
        prc.logger = getInstance( prc.settings.logger );
        event.noLayout();
    }

}
