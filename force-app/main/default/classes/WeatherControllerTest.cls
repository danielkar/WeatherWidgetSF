@isTest
public class WeatherControllerTest {
    @testSetup static void setup() {
        List<Account> accList = new List<Account>();
        Account acc1 = new Account(Name = 'Test1');
        accList.add(acc1);
        Account acc2 = new Account(Name = 'Test2', BillingCity = 'New York');
        accList.add(acc2);
        Account acc3 = new Account(Name = 'Test3', BillingCity = 'New York', BillingState = 'New York');
        accList.add(acc3);
        Account acc4 = new Account(Name = 'Test4', BillingCity = 'New York', BillingState = 'New York', BillingCountry = 'United States');
        accList.add(acc4);
        Account acc5 = new Account(Name = 'Test5', BillingCountry = 'United States', BillingPostalCode = '10110');
        accList.add(acc5);
        insert accList;
    }

    @isTest
    static void testGetWeatherDataWithoutAddress() {
        Test.setMock(HttpCalloutMock.class, new WeatherCalloutMock());

        Id accId = [SELECT Id FROM Account WHERE Name='Test1'].Id;

        Test.startTest();
        WeatherController.WeatherData data = WeatherController.getWeatherData(accId);
        System.assertEquals(null, data);
        Test.stopTest();
    }

    @isTest
    static void testGetWeatherDataWithCity() {
        Test.setMock(HttpCalloutMock.class, new WeatherCalloutMock());

        Id accId = [SELECT Id FROM Account WHERE Name='Test2'].Id;

        Test.startTest();
        WeatherController.WeatherData data = WeatherController.getWeatherData(accId);
        System.assertNotEquals(null, data);
        Test.stopTest();
    }

    @isTest
    static void testGetWeatherDataWithCityAndState() {
        Test.setMock(HttpCalloutMock.class, new WeatherCalloutMock());

        Id accId = [SELECT Id FROM Account WHERE Name='Test3'].Id;

        Test.startTest();
        WeatherController.WeatherData data = WeatherController.getWeatherData(accId);
        System.assertNotEquals(null, data);
        Test.stopTest();
    }

    @isTest
    static void testGetWeatherDataWithCityStateCountry() {
        Test.setMock(HttpCalloutMock.class, new WeatherCalloutMock());

        Id accId = [SELECT Id FROM Account WHERE Name='Test4'].Id;

        Test.startTest();
        WeatherController.WeatherData data = WeatherController.getWeatherData(accId);
        System.assertNotEquals(null, data);
        Test.stopTest();
    }

    @isTest
    static void testGetWeatherDataWithStateZip() {
        Test.setMock(HttpCalloutMock.class, new WeatherCalloutMock());

        Id accId = [SELECT Id FROM Account WHERE Name='Test5'].Id;

        Test.startTest();
        WeatherController.WeatherData data = WeatherController.getWeatherData(accId);
        System.assertNotEquals(null, data);
        Test.stopTest();
    }

    @isTest
    static void testGetWeatherWithoutData() {
        Test.setMock(HttpCalloutMock.class, new EmptyCalloutMock());

        Id accId = [SELECT Id FROM Account WHERE Name='Test2'].Id;

        Test.startTest();
        WeatherController.WeatherData data = WeatherController.getWeatherData(accId);
        System.assertEquals(null, data);
        Test.stopTest();
    }

    
}
