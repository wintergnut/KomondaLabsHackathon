({
    doInit: function(component, event, helper)
    {
        component.set("v.GeoInfo",{"Lat":48.8534100,"Long":2.3488000,"Zoom":14,"Radius":500});
    },
	showNext: function(component, event, helper)
    {
        var updatedNumber=component.get("v.CurrentPage");
        updatedNumber=updatedNumber+1;
        component.set("v.CurrentPage",updatedNumber);
        console.log(component.get("v.CurrentPage"));
    },
    showPrev: function(component, event, helper)
    {
        var updatedNumber=component.get("v.CurrentPage");
        updatedNumber=updatedNumber-1;
        component.set("v.CurrentPage",updatedNumber);
        console.log(component.get("v.CurrentPage"));
    },
    updateGeo: function(component, event,helper)
    {
        var geo=event.getParam("Geo");
        component.set("v.GeoInfo",geo);
        console.log("put "+component.get("v.GeoInfo").Lat+" "+component.get("v.GeoInfo").Long);
    },
    updateGroups: function(component, event,helper)
    {
        var geo=event.getParam("Groups");
        component.set("v.Groups",geo);
        console.log("groups "+component.get("v.Groups"));
    }
})