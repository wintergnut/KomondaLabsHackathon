({
	doEdit: function(component, event, helper) 
	{
		component.set("v.showGroupWindow",true);
	},
	doSave: function(component, event, helper) 
	{
		component.set("v.currentGroup.Name",event.getParam("groupName"));
        component.set("v.currentGroup.PeopleList",event.getParam("peopleList"));
        component.set("v.currentGroup.arrival",event.getParam("arrival"));
        component.set("v.currentGroup.departure",event.getParam("departure"));
        component.set("v.currentGroup.minPrice",event.getParam("minPrice"));
        component.set("v.currentGroup.maxPrice",event.getParam("maxPrice"));
        component.set("v.currentGroup.minDistance",event.getParam("minDistance"));
        component.set("v.currentGroup.maxDistance",event.getParam("maxDistance"));
        component.set("v.currentGroup.Adults",event.getParam("Adults"));
        component.set("v.currentGroup.Children",event.getParam("Children"));
        component.set("v.currentGroup.VIP",event.getParam("VIP"));
        component.set("v.currentGroup.Pool",event.getParam("Pool"));
        component.set("v.currentGroup.Parking",event.getParam("Parking"));


		component.set("v.showGroupWindow",false);
		event.stopPropagation();

		var compEvent = component.getEvent("triggerRecalculateInParent");
		compEvent.fire();
	},
	doCancel: function(component, event, helper) 
	{
		component.set("v.showGroupWindow",false);
		event.stopPropagation();
	},
    doDelete: function(component, event, helper) 
	{
        var compEvent = component.getEvent("deleteGroup");
        compEvent.setParams({"groupNumber" : component.get("v.currentGroupNumber")});
		compEvent.fire();
	},
	handleSelect: function(component, event, helper) 
	{  
        var compEvent = component.getEvent("triggerRecalculateInParent");
		compEvent.fire();
	}
})