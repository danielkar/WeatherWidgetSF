public class WeatherCallouts {
    public static HttpResponse makeGetCallout(String endPoint){
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setMethod('GET');
        request.setEndpoint(endPoint);
        HTTPResponse response = http.send(request);
        
        return response;
    }
}
