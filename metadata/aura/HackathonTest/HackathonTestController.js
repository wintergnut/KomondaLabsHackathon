({
	doInit: function(component, event, helper) 
	{
		window.addEventListener('mouseup', function(event){
			console.log("UP");
			var compEvent = $A.get("e.c:GroupAddWindowPersonLineMouseUp");
			compEvent.fire();
		});
	}
})