({
	jsLoaded: function(component, event, helper) 
    {
        var StartingGeo=component.get("v.InitGeoInfo");
        console.log("init"+StartingGeo.Lat+" "+StartingGeo.Long);


    	setTimeout(function() 
        {
        	window.leafletMap = L.map('map', {zoomControl: false}).setView({"lat":StartingGeo.Lat, "lng":StartingGeo.Long}, StartingGeo.Zoom);
        	L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}').addTo(window.leafletMap);
        	// Add marker
        	window.mainMarker=L.marker({"lat":StartingGeo.Lat, "lng":StartingGeo.Long}).addTo(window.leafletMap);
            window.leafletCircle = L.circle({"lat":StartingGeo.Lat, "lng":StartingGeo.Long}, StartingGeo.Radius, {color: 'red',fillColor: 'red',fillOpacity: 0.5}).addTo(window.leafletMap);
            
            window.leafletMap.on('click', function (e) 
            {
                helper.moveMarkerAndCircle(e.latlng);

                var compEvent = component.getEvent("updateGeo");
                compEvent.setParams({ "Geo" : {"Lat":window.mainMarker.getLatLng().lat,"Long":window.mainMarker.getLatLng().lng,"Zoom":14,"Radius":window.leafletCircle.getRadius()}});
                compEvent.fire();

            });
            window.leafletMap.on('mouseup', function (e) 
            {
                var DraggingCircle=component.get("v.DraggingCircle");
                if(DraggingCircle===true && e.latlng.lat!=component.get("v.DragStartLatLong").lat && e.latlng.lng!=component.get("v.DragStartLatLong").lng)
                {
                    component.set("v.DraggingCircle", false);
                    window.leafletCircle.setRadius(e.latlng.distanceTo(window.leafletCircle.getLatLng()));
                    
                    var compEvent = component.getEvent("updateGeo");
                    compEvent.setParams({ "Geo" : {"Lat":window.mainMarker.getLatLng().lat,"Long":window.mainMarker.getLatLng().lng,"Zoom":14,"Radius":window.leafletCircle.getRadius()}});
                    compEvent.fire();
                }
            });

            window.leafletCircle.on('mousedown', function(e) 
            {
                component.set("v.DraggingCircle", true);
                component.set("v.DragStartLatLong", e.latlng);
            });
        });
    },
    searchGeoCode: function(component, event, helper) 
    {
        var action = component.get("c.GeoCodeLocation");
        action.setParams({"address" : component.find("addressInput").get("v.value")});
        console.log(component.find("addressInput").get("v.value"));

        action.setCallback(this, function(response) {
                var newCoordinates=JSON.parse(response.getReturnValue());
                window.leafletMap.setView([newCoordinates[0].lat, newCoordinates[0].lon]);
                helper.moveMarkerAndCircle([newCoordinates[0].lat, newCoordinates[0].lon]);

                var compEvent = component.getEvent("updateGeo");
                compEvent.setParams({ "Geo" : {"Lat":window.mainMarker.getLatLng().lat,"Long":window.mainMarker.getLatLng().lng,"Zoom":14,"Radius":window.leafletCircle.getRadius()}});
                compEvent.fire();
        });

        $A.enqueueAction(action);
    }
})