({
	doInit : function(component, event, helper) 
    {
        var group=component.get("v.Group");
        if(component.get("v.Group"))
        {
            component.find("groupNameInput").set("v.value",group.Name);
            component.find("numberOfMembersInput").set("v.value",group.PeopleList.length);
            component.set("v.PeopleList",group.PeopleList.slice());
            component.find("Arrival").set("v.value",group.arrival);
            component.find("Departure").set("v.value",group.departure);
            component.set("v.minPrice",group.minPrice);
            component.set("v.maxPrice",group.maxPrice);
            component.set("v.minDistance",group.minDistance);
            component.set("v.maxDistance",group.maxDistance);
            component.find("Adults").set("v.value",group.Adults);
            component.find("Children").set("v.value",group.Children);
            component.find("VIP").set("v.value",group.VIP);
            component.find("Pool").set("v.value",group.Pool);
            component.find("Parking").set("v.value",group.Parking);
        }
        else
            component.find("numberOfMembersInput").set("v.value",30);
	},
    handleSave: function(component, event, helper) 
    {
        	var people=component.get("v.PeopleList");
        	var memberNumber=component.find("numberOfMembersInput").get("v.value");

                for(i=people.length;i<memberNumber;i++)
                    people.push({"Name":"Tom Smith "+(i+1).toString()});
                for(i=memberNumber;i<people.length;i++)
                    people.pop();
        	
            var compEvent = component.getEvent("doSave");
            compEvent.setParams({
                                    "groupName"         : component.find("groupNameInput").get("v.value"),
                                    "membersNumber"     : people.length,
                					"peopleList"        : people,
                                    "arrival"           : component.find("Arrival").get("v.value"),
                                    "departure"         : component.find("Departure").get("v.value"),
                                    "minPrice"          : component.get("v.minPrice"),
                                    "maxPrice"          : component.get("v.maxPrice"),
                                    "minDistance"       : component.get("v.minDistance"),
                                    "maxDistance"       : component.get("v.maxDistance"),
                                    "Adults"            : component.find("Adults").get("v.value"),
                                    "Children"          : component.find("Children").get("v.value"),
                                    "VIP"               : component.find("VIP").get("v.value"),
                                    "Pool"              : component.find("Pool").get("v.value"),
                                    "Parking"           : component.find("Parking").get("v.value")
                                });
            compEvent.fire();
	},
	handleCancel: function(component, event, helper) 
    {
        var compEvent = component.getEvent("doCancel");
		compEvent.fire();
	},
    handleDelete: function(component, event, helper) 
    {
        var PeopleList=component.get("v.PeopleList");
        for(i=PeopleList.length-1;i>=0;i--)
        {
            if(PeopleList[i].Selected==true)
                PeopleList.splice(i,1);
        }
        component.set("v.PeopleList",PeopleList);
    },
    handleAdd: function(component, event, helper) 
    {
        var PeopleList=component.get("v.PeopleList");
        PeopleList.push({"Name":"guest"+(PeopleList.length+1).toString()});
        component.set("v.PeopleList",PeopleList); 
    },
    togglePeople: function(component, event, helper) 
    {
        console.log(component.get("v.showPeople"));
        var varToToggle = component.get("v.showPeople");
        component.set("v.showPeople",!varToToggle);

    },
	jsLoaded: function(component, event, helper) 
    {
        var sliders = document.getElementsByClassName("twoWaySlider");
        for ( var i = 0; i < sliders.length; i++ )
        {
            if(i==0)
        	   noUiSlider.create(sliders[i], {start: [component.get("v.minPrice"),component.get("v.maxPrice")],range: {'min': 0,'max': 15000},orientation: 'vertical',connect: true});
            else
               noUiSlider.create(sliders[i], {start: [component.get("v.minDistance"),component.get("v.maxDistance")],range: {'min': 0,'max': 3000},orientation: 'vertical',connect: true});

            var connectBar = document.createElement('div'),
            connectBase = sliders[i].querySelector('.noUi-base');

            // Give the bar a class for styling and add it to the slider.
            connectBar.className += 'connect';
            connectBase.appendChild(connectBar);
        }

        sliders[0].noUiSlider.on('update', function( values, handle, a, b, handlePositions ) 
            {
                if (handle)
                    component.set("v.minPrice",(15000-values[handle]).toFixed(2));
                else 
                    component.set("v.maxPrice",(15000-values[handle]).toFixed(2));
            });
        sliders[1].noUiSlider.on('update', function( values, handle, a, b, handlePositions ) 
            {
                if (handle)
                    component.set("v.minDistance",(3000-values[handle]).toFixed(2));
                else 
                    component.set("v.maxDistance",(3000-values[handle]).toFixed(2));
            });
    }
})