({
	fireMouseDown: function(component, event, helper) 
	{
		component.set("v.InitObj.Selected",!component.get("v.InitObj.Selected"));
		var compEvent = $A.get("e.c:GroupAddWindowPersonLineMouseDown");
		compEvent.fire();

		console.log("fired");
	},
	handleMouseDown: function(component, event, helper) 
	{
		component.set("v.MbDown",true);
		console.log("handled");
	},
	handleHover: function(component, event, helper) 
	{
		console.log(component.get("v.MbDown"));

		if(component.get("v.MbDown")==true)
			component.set("v.InitObj.Selected",!component.get("v.InitObj.Selected"));
	},
	handleMouseUp: function(component, event, helper) 
	{
		component.set("v.MbDown",false);
	},
	doInit: function(component, event, helper) 
	{
		component.set("v.InitObj.Selected",false);
	}
})