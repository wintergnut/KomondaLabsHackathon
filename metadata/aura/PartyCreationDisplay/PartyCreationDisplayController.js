({
	CreateGroup : function(component, event, helper) 
    {
        component.set("v.showGroupWindow", true);
	},
    HideGroupWindow : function(component, event, helper) 
    {
        component.set("v.showGroupWindow", false);
    },
    handleNewGroupSave : function(component, event, helper) 
    {
        var expenses = component.get("v.AuGroupList");
        expenses.push({"Name":event.getParam("groupName"),
                        "AccountNights__c"  :event.getParam("membersNumber"),
                        "PeopleList"        :event.getParam("peopleList"),
                        "arrival"           :event.getParam("arrival"),
                        "departure"         :event.getParam("departure"),
                        "minPrice"          :event.getParam("minPrice"),
                        "maxPrice"          :event.getParam("maxPrice"),
                        "minDistance"       :event.getParam("minDistance"),
                        "maxDistance"       :event.getParam("maxDistance"),
                        "Adults"            :event.getParam("Adults"),
                        "Children"          :event.getParam("Children"),
                        "VIP"               :event.getParam("VIP"),
                        "Pool"              :event.getParam("Pool"),
                        "Parking"           :event.getParam("Parking")});

		component.set("v.AuGroupList", expenses);
        component.set("v.showGroupWindow", false);

        console.log("save called")
        helper.updateGroupsInParent(component);
	},
	RecalculateSelected : function(component, event, helper) 
    {
        helper.updateGroupsInParent(component);
	},
    handleDelete: function(component, event,helper)
    {
        console.log("deleting");
        var groupList=component.get("v.AuGroupList");
        var groupToDelete=event.getParam("groupNumber");
        groupList.splice(groupToDelete,1);
        component.set("v.AuGroupList",  groupList);
        
        helper.updateGroupsInParent(component);
    },
    sendToController: function(component, event, helper) 
    {
        var listToSave=component.get("v.PeopleListToSendToServer");
        var groups=component.get("v.AuGroupList");
        for(i=0;i<groups.length;i++)
        {
            var people=groups[i].PeopleList;
            for(j=0;j<people.length;j++)
                listToSave.push({"rooms":"1","name":people[j].Name,"groupNumber":i.toString()});
        }
        var action = component.get("c.ProcessIndividualInfo");
        action.setParams({"Source" : JSON.stringify(listToSave)});

        $A.enqueueAction(action);
    }
})