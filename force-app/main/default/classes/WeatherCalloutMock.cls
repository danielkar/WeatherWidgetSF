@isTest
public class WeatherCalloutMock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"coord":{"lon":27.5667,"lat":53.9},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"stations","main":{"temp":288.15,"feels_like":287.22,"temp_min":288.15,"temp_max":288.15,"pressure":1003,"humidity":58},"visibility":10000,"wind":{"speed":8,"deg":200,"gust":12},"clouds":{"all":75},"dt":1620209602,"sys":{"type":1,"id":8939,"country":"US","sunrise":1620181526,"sunset":1620236840},"timezone":10800,"id":625144,"name":"New York","cod":200}');
        response.setStatusCode(200);
        return response;
    }
}

