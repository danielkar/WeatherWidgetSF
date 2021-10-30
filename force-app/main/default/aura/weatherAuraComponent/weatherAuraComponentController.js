({
    doInit : function(component, event, helper) {
        component.set('v.areDetailsVisible', false);
        //call WeatherHelper method
        helper.getWeatherHelper(component, event, helper);
    },

    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for displaying loading spinner 
        component.set("v.spinner", true); 
    },
     
    // function automatic called by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        // make Spinner attribute to false for hiding loading spinner    
        component.set("v.spinner", false);
    }
})
