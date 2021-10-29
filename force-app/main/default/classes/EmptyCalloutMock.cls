public class EmptyCalloutMock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"name":"New York","cod":200}');
        response.setStatusCode(200);
        return response;
    }
}

