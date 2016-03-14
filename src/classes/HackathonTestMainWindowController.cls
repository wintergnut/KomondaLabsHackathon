public with sharing class HackathonTestMainWindowController 
{
    @AuraEnabled
    public static Account[] AddGroup(string accName,integer MembersNumber,Account[] AccountList) 
    {
        AccountList.add(new Account(Name=accName));
        system.debug(AccountList.size());
        return AccountList;
    }
    
    @AuraEnabled
    public static string GeoCodeLocation(string address) 
    {
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        system.debug(address);
        req.setEndpoint('http://nominatim.openstreetmap.org/search?format=json&q='+address);
        req.setMethod('GET');

        res = http.send(req);
        
        return res.getBody();
    }

    public class IndividualInfo
    {
        public string rooms;
        public string adults;
        public string children;
        public string name;
        public string startDate;
        public string endDate;
        public string groupNumber;
        public string individualNumber;
        public string priceMin;
        public string priceMax;
        public string distMin;
        public string distMax;
        public string doNotMove;
        public string familyFriendly;
        public string pool;
        public string parking;
        public string vip;
        public HackathonHotelsBedController.HotelResult hotelResult;

        public IndividualInfo(){
            
        }
    }

    public class GeoS
    {
        public decimal Lat;
        public decimal Lon;
        public decimal Zoom;
        public decimal Radius;
        
        public GeoS()
        {
        }
    }

    public class DateRange
    {
        public date Arrival;
        public date Departure;
        
        public DateRange()
        {
        }
    }


    @AuraEnabled
    public static String ProcessIndividualInfo(string IndividualInfoSource,string GeoObj, string DateRanges)
    {
            system.debug(IndividualInfoSource);
            system.debug(GeoObj);
            system.debug(DateRanges);
            List<IndividualInfo> IndividualInfos=(List<IndividualInfo>)System.JSON.deserialize(IndividualInfoSource, List<IndividualInfo>.class);
            
            GeoS Geo=(GeoS)System.JSON.deserialize(GeoObj,GeoS.class);
            DateRange Dates=(DateRange)System.JSON.deserialize(DateRanges,DateRange.class);
            
            system.debug(String.valueOf(Dates.Arrival));

            return HackathonHotelsBedController.processData(new HackathonHotelsBedController.stay(String.valueOf(Dates.Arrival),String.valueOf(Dates.Departure),'1'), new HackathonHotelsBedController.geolocation(String.valueOf(Geo.Lon), String.valueOf(Geo.Lat), String.valueOf(Geo.Radius/1000),'km'), IndividualInfos);
    }
}