({
	updateGroupsInParent: function(component) 
    {
        var compEvent = component.getEvent("updateGroups");
        console.log(component.get("v.AuGroupList").length);
        compEvent.setParams({ "Groups" : component.get("v.AuGroupList")});
        compEvent.fire();
    }
})