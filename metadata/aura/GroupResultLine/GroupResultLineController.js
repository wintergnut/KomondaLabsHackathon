({
	doInit: function(component, event, helper) 
	{
		var StartDate=component.get("v.InitObj.arrival");
		var EndDate=component.get("v.InitObj.departure");
		
		var dateFormat = "MM dd, yyyy";
		var userLocaleLang = $A.get("$Locale.langLocale");
		component.set("v.DateLine",'( '+$A.localizationService.formatDate(StartDate, dateFormat, userLocaleLang)+' - '+$A.localizationService.formatDate(EndDate, dateFormat, userLocaleLang)+')');
	}
})