import { LightningElement, wire, api } from 'lwc';
import getWeatherData from '@salesforce/apex/WeatherController.getWeatherData';

export default class WeatherComponent extends LightningElement {
    areDetailsVisible = false;
    temperature;
    speed;
    cloud;
    error;
    @api recordId;

    @wire(getWeatherData, { accountId: '$recordId' })
    wiredWeather({ error, data }) {
        if (data) {
            if(data == undefined) {
                this.areDetailsVisible = false; 
            } else {
                this.areDetailsVisible = true; 
                this.temperature = data.convertedTemp + '°';
                this.speed = data.windSpeed + ' mph';
                this.cloud = data.cloudCover;
            }
        } else if (error) {
            this.error = error;
        }
    }
}