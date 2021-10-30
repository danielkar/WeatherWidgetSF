public class WeatherController {
    @AuraEnabled(cacheable=true)
    public static WeatherData getWeatherData(Id accountId) {
        List<Account> accList = [SELECT Id, BillingAddress FROM Account WHERE Id=:accountId];

        WeatherData weather = new WeatherData();

        for(Account acc: accList) {
            String city = acc.BillingAddress.getCity();
            String countryCode = acc.BillingAddress.getCountryCode();
            String stateCode = acc.BillingAddress.getStateCode();
            String zipCode = acc.BillingAddress.getPostalCode();

            if(countryCode != null && zipCode != null) {
                weather = getWeatherByZip(zipCode, countryCode);
                if(weather == null && city != null) {
                    weather = getCityWeather(city);
                }
            }
            else if(city != null && stateCode != null && countryCode != null) {
                weather = getCityStateCountryWeather(city, stateCode, countryCode);
                if(weather == null && city != null) {
                    weather = getCityWeather(city);
                }
            }
            else if(city != null) {
                weather = getCityWeather(city);
            } 
            else {
                weather = null;
            }
        }

        return weather;
    }

    private static WeatherData getWeatherByZip(String zipCode, String countryCode) {
        String endPoint = getMetadata().url + 'zip=' + zipCode + ',' + countryCode + '&appid=' + getMetadata().apiKey;
        HTTPResponse response = WeatherCallouts.makeGetCallout(endPoint);

        WeatherData weather = parseBody(response);

        return weather;
    }

    private static WeatherData getCityWeather(String city) {
        String cityWithoutSpaces = city.replace(' ','+');
        String endPoint = getMetadata().url + 'q=' + cityWithoutSpaces + '&appid=' + getMetadata().apiKey;
        HTTPResponse response = WeatherCallouts.makeGetCallout(endPoint);
        
        WeatherData weather = parseBody(response);

        return weather;
    }

    private static WeatherData getCityStateCountryWeather(String city, String stateCode, String countryCode) {
        String cityWithoutSpaces = city.replace(' ','+');
        String endPoint = getMetadata().url + 'q=' + cityWithoutSpaces + ',' + stateCode + ',' + countryCode + '&appid=' + getMetadata().apiKey;
        HTTPResponse response = WeatherCallouts.makeGetCallout(endPoint);

        WeatherData weather = parseBody(response);

        return weather;
    }

    private static WeatherData parseBody(HTTPResponse response) {
        WeatherData weather = new WeatherData();

        String body = response.getBody();

        if(response.getStatusCode() == 200) {
            System.JSONParser Parser = JSON.createParser(body);
            while(Parser.nextToken() != Null){
                String key = Parser.getText();
                if(key == 'temp') {
                    Parser.nextToken();
                    String temperature = (String)Parser.getText();
                    weather.convertedTemp = Decimal.valueOf(temperature) - 273;
            	} else if (key == 'speed'){
                    Parser.nextToken();
                    weather.windSpeed = (String)Parser.getText();
                } else if (key == 'description'){
                    Parser.nextToken();
                    weather.cloudCover = (String)Parser.getText();
                }
            }
        }

        if(weather.convertedTemp != null || weather.windSpeed != null || weather.cloudCover != null) {
            return weather;
        } else {
            return null;
        }
    }

    private static ApiData getMetadata() {
        List<Weather__mdt> metadata = [SELECT API_Key__c, URL__c FROM Weather__mdt LIMIT 1];
        ApiData apiData = new ApiData();

        for(Weather__mdt md: metadata) {
            apiData.apiKey = md.API_Key__c;
            apiData.url = md.URL__c;
        }

        return apiData;
    }

    public class WeatherData {
        @AuraEnabled public Decimal convertedTemp;
        @AuraEnabled public String windSpeed;
        @AuraEnabled public String cloudCover;
    }

    private class ApiData {
        public String apiKey;
        public String url;
    }
}
