public with sharing class HackatonHotelsBedResponseWrapper {
	public HackatonHotelsBedResponseWrapper() {
		
	}
	//responce classes;
	public class ResponceWrapper{
		public auditData auditData;
		public hotelsWrapper hotels;
	}

	public class auditData{
		public string processTime;
		public string timestamp;
		public string requestHost;
		public string serverId;
		public string environment;
		public string release;
		public string internal;
	}

	public class hotelsWrapper{
		public List<hotels> hotels;
		public string checkIn;
		public string checkOut;
		public string total;
	}

	public class hotels{
		public string code;
		public string name;
		public string categoryCode;
		public string categoryName;
		public string destinationCode;
		public string destinationName;
		public string zoneCode;
		public string zoneName;
		public string latitude;
		public string longitude;
		public List<rooms> rooms;
		public string minRate;
		public string maxRate;
		public string currency_x;
		public List<creditCards> creditCards;
	}

	public class shiftRates{
		public string rateKey;
		public string rateClass;
		public string rateType;
		public string net;
		public string sellingRate;
		public string hotelMandatory;
		public string allotment;
		public string checkIn;
		public string checkOut;
	}

	public class rates{
		public string paymentType;
		public string boardCode;
		public string boardName;
		public string rooms;
		public string adults;
		public string children;
		public string childrenAges;
		public List<shiftRates> shiftRates;
	}

	public class rooms{
		public string code;
		public string name;
		public List<rates> rates;
	}

	public class creditCards{
		public string code;
		public string name;
		public string paymentType;
	}
}