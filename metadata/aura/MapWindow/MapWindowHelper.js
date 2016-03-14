({
	moveMarkerAndCircle: function(destination)
    {
        window.mainMarker.setLatLng(destination);
        window.leafletCircle.setLatLng(destination)
    }
})