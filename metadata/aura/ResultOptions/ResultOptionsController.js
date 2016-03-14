({
	doInit: function(component, event, helper) 
	{
        var listToSave=[];
        var groups=component.get("v.InitGroups");
        var geo=component.get("v.InitGeo");
        geo.Lon=geo.Long;
        var minArrival;
        var maxDeparture;

        for(i=0;i<groups.length;i++)
        {
            var people=groups[i].PeopleList;
            for(j=0;j<people.length;j++)
                listToSave.push({	"rooms":"1",
                					"name":people[j].Name,
                					"groupNumber":i.toString(),
                                    "individualNumber":j.toString(),
        							"adults":groups[i].Adults,
							        "children":groups[i].Children,
							        "startDate":groups[i].arrival,
							        "endDate":groups[i].departure,
							        "priceMin":groups[i].minPrice.toString(),
							        "priceMax":groups[i].maxPrice.toString(),
							        "distMin":groups[i].minDistance.toString(),
							        "distMax":groups[i].maxDistance.toString(),
							        "doNotMove":"true",
							        "familyFriendly":"true",
							        "pool":groups[i].Pool.toString(),
							        "parking":groups[i].Parking.toString(),
							        "vip":groups[i].VIP.toString()
                				});
            if(groups[i].arrival<minArrival || i==0)
            	minArrival=groups[i].arrival;
            if(groups[i].departure>maxDeparture || i==0)
            	maxDeparture=groups[i].departure;
        }
        component.set("v.ShowSplash",true);
        var action = component.get("c.ProcessIndividualInfo");
        action.setParams({"IndividualInfoSource" : JSON.stringify(listToSave),
        	"GeoObj" : JSON.stringify(geo),
        	"DateRanges" : JSON.stringify({"Arrival":minArrival,"Departure":maxDeparture})
        });

        action.setCallback(this, function(response) 
        {
        	var temp=JSON.parse(response.getReturnValue());
            var final=new Map();
            var groups=component.get("v.InitGroups");
            var staying=1;
            var Rate;

            for(i=0;i<temp.length;i++)
            {
                staying=parseInt(temp[i].adults)+parseInt(temp[i].children);
                groups[parseInt(temp[i].groupNumber)].PeopleList[parseInt(temp[i].individualNumber)].Hotel=temp[i].hotelResult.name;
                groups[parseInt(temp[i].groupNumber)].PeopleList[parseInt(temp[i].individualNumber)].Rating=temp[i].hotelResult.rating;
                if(staying==1)
                {
                    groups[parseInt(temp[i].groupNumber)].PeopleList[parseInt(temp[i].individualNumber)].Room=temp[i].hotelResult.SingleRoomName;
                    Rate=parseInt(temp[i].hotelResult.minRateSingle);
                    groups[parseInt(temp[i].groupNumber)].PeopleList[parseInt(temp[i].individualNumber)].Rate=(Rate > 0 ?  Rate: (parseFloat(temp[i].priceMin)+parseFloat(temp[i].priceMax))/2);
                }
                if(staying==2)
                {
                    groups[parseInt(temp[i].groupNumber)].PeopleList[parseInt(temp[i].individualNumber)].Room=temp[i].hotelResult.DoubleRoomName;
                    Rate=parseInt(temp[i].hotelResult.minRateDouble);
                    groups[parseInt(temp[i].groupNumber)].PeopleList[parseInt(temp[i].individualNumber)].Rate=(Rate > 0 ?  Rate:(parseFloat(temp[i].priceMin)+parseFloat(temp[i].priceMax))/2);
                }
                if(staying==3)
                {
                    groups[parseInt(temp[i].groupNumber)].PeopleList[parseInt(temp[i].individualNumber)].Room=temp[i].hotelResult.TripleRoomName;
                    Rate=parseInt(temp[i].hotelResult.minRateTriple);
                    groups[parseInt(temp[i].groupNumber)].PeopleList[parseInt(temp[i].individualNumber)].Rate=(Rate > 0 ?  Rate:(parseFloat(temp[i].priceMin)+parseFloat(temp[i].priceMax))/2);
                }
                if(staying==4)
                {
                    groups[parseInt(temp[i].groupNumber)].PeopleList[parseInt(temp[i].individualNumber)].Room=temp[i].hotelResult.QuadRoomName;
                    Rate=parseInt(temp[i].hotelResult.minRateQuad);
                    groups[parseInt(temp[i].groupNumber)].PeopleList[parseInt(temp[i].individualNumber)].Rate=(Rate > 0 ?  Rate:(parseFloat(temp[i].priceMin)+parseFloat(temp[i].priceMax))/2);
                }
            }
            component.set("v.InitGroups",groups);
        	console.log("response"+response.getReturnValue());
            console.log(component.get("v.InitGroups"))
        	component.set("v.ShowSplash",false);

        });

        $A.enqueueAction(action);
	}
})