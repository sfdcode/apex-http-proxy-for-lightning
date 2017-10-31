public class HttpService {
    public class Request {
    	public String method {get;set;}
    	public String body {get;set;}
    	public String clientCertificateName {get;set;}
    	public Boolean compressed {get;set;}
   	 	public String endPoint {get;set;}
    	public Integer timeout {get;set;}
    	public Map<String, String> headers {get;set;}
	}

    public class Response {
    	public String status {get;set;}
    	public String body {get;set;}
    	public Integer statusCode {get;set;}
    	public Map<String, String> headers {get;set;}
	}
    
    public static HttpService.Response send(HttpService.Request request) {
        System.debug(request);
        Http http = new Http();
        HttpRequest req = new HttpRequest();
       	HttpService.Response response = null;
        try {    
        	if (String.isNotEmpty(request.body))
	        	req.setBody(request.body);        
        	req.setMethod(request.method);
	        if (String.isNotEmpty(request.clientCertificateName)) {
		        req.setClientCertificateName(request.clientCertificateName);
        	}        
        	req.setCompressed(request.compressed);
	        req.setEndpoint(request.endpoint);
	        if (request.timeout != null)
    	        req.setTimeout(request.timeout);
		    for (String key : request.headers.keySet()) {
    			req.setHeader(key, request.headers.get(key));
        	}
	        HttpResponse resp = http.send(req);
    	    response = new HttpService.Response();
        	response.status = resp.getStatus();
	        response.statusCode = resp.getStatusCode();
    	    response.body = resp.getBody();
        	Map<String, String> headerMap = new Map<String, String>();
	        for (String key : resp.getHeaderKeys()) {
    	        headerMap.put(key, resp.getHeader(key));
        	}
        	response.headers = headerMap;
        	return response;
        } catch (System.CalloutException e) {
            response = new HttpService.Response();
            response.status = 'CALLOUT_ERROR';
            response.statusCode = -1;
            response.body = e.getMessage();
            System.debug(response);
            return response;
        } catch (Exception ex) {
            response = new HttpService.Response();
            response.status = 'UNEXPECTED_ERROR';
            response.statusCode = -2;
            response.body = ex.getMessage();
            System.debug(response);
            return response;            
        }     
    }
}