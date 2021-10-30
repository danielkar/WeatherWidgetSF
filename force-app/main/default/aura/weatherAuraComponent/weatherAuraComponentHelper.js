({
    getWeatherHelper : function(component, event, helper) {
        var accountId = component.get('v.recordId');
        var action = component.get('c.getWeatherData');
        action.setParams({ accountId : accountId })
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if(response.getReturnValue() != undefined){
                    component.set('v.areDetailsVisible', true);
                    component.set('v.temp', response.getReturnValue().convertedTemp + '°');
                    component.set('v.cloud', response.getReturnValue().cloudCover);
                    component.set('v.speed', response.getReturnValue().windSpeed);
                }
            }
        });
        $A.enqueueAction(action);
    }
})
