@isTest
private class HttpServiceTest {
     @isTest static void testCalloutOK() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new HttpServiceMockResponseGenerator());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock.
        HttpService.Request req = new HttpService.Request();
        req.endPoint = 'http://api.salesforce.com/foo/bar';
        req.method = 'GET';
        req.body = '';
        req.timeout = 5000;
        req.clientCertificateName = null;
        req.compressed = false;
        Map<String, String> headers = new Map<String, String>();
        req.headers = headers;
        HttpService.Response res = HttpService.send(req);
        
        // Verify response received contains fake values
        String contentType = res.headers.get('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.body;
        String expectedValue = '{"foo":"bar"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.statusCode);
    }
    
    @isTest static void testCalloutException() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new HttpServiceMockResponseGenerator());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock.
        HttpService.Request req = new HttpService.Request();
        req.endPoint = 'http://api.salesforce.com/calloutException';
        req.method = 'GET';
        req.body = '';
        req.timeout = 5000;
        // this param throws the exception
        req.clientCertificateName = 'test';
        req.compressed = false;
        Map<String, String> headers = new Map<String, String>();
        req.headers = headers;
        HttpService.Response res = HttpService.send(req);
        System.assertEquals(-1, res.statusCode);
    }
    
        @isTest static void testGeneralException() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new HttpServiceMockResponseGenerator());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock.
        HttpService.Request req = new HttpService.Request();
        req.endPoint = 'http://api.salesforce.com/generalException';
        req.method = 'POST';
        req.body = 'A=B';
        req.timeout = 5000;
        req.clientCertificateName = '';
        req.compressed = false;
        Map<String, String> headers = new Map<String, String>();
        headers.put('Content-Type', 'application/json');
        req.headers = headers;
        HttpService.Response res = HttpService.send(req);
        System.assertEquals(-2, res.statusCode);
    }
}