@isTest
global class HttpServiceMockResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.

		HttpResponse res = null;
        if (req.getEndPoint().contains('/foo/bar')) {
            System.assertEquals('GET', req.getMethod());
        	System.assertEquals('http://api.salesforce.com/foo/bar', req.getEndpoint());
	        res = new HttpResponse();
    	    res.setHeader('Content-Type', 'application/json');
       	 	res.setBody('{"foo":"bar"}');
        	res.setStatusCode(200);

        } else if (req.getEndPoint().contains('/calloutException')) {
            System.assertEquals('GET', req.getMethod());
        } else if (req.getEndPoint().contains('/generalException')) {
            System.assertEquals('POST', req.getMethod());
        	throw new System.SObjectException('generalException message');            
        }
        return res;
    }
}