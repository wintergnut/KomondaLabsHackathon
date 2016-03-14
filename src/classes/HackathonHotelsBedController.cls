public with sharing class HackathonHotelsBedController {
	public HackathonHotelsBedController() {
		
	}

	//request classes

	public class stay{
		public string checkIn;
		public string checkOut;
		public string shiftDays;

		public stay(String ci, String co, String sd){
			this.checkIn = ci;
			this.checkOut = co;
			this.shiftDays = sd;
		}
	}

	public class paxes{
		public string type;
		public string age;

		public paxes(String t, String a){
			this.type = t;
			this.age = a; 
		}
	}

	public class occupancies{
		public string rooms;
		public string adults;
		public string children;
		public List<paxes> paxes;

		public occupancies(String r, String a, String c, List<paxes> p){
			this.rooms = r;
			this.adults = a;
			this.children = c;
			this.paxes = p;
		}
	}

	public class hotel{
		public List<String> hs;

		public hotel(List<String> h){
			this.hs = h;
		}
	}

	public class hotels{
		public hotel hotel;

		public hotels(hotel h){
			this.hotel = h;
		}
	}

	public class destination{
		public string code;
		public string zone;

		public destination(String c, String z){
			this.code = c;
			this.zone = z;
		}
	}

	public class geolocation{
		public string longitude;
		public string latitude;
		public string radius;
		public string unit;

		public geolocation(String lo, String la, String ra, String un){
			this.longitude = lo;
			this.latitude = la;
			this.radius = ra;
			this.unit = un;
		}

	}

	public class searchHotelByCircleRequest{
		public stay stay;
		public List<occupancies> occupancies;
		public geolocation geolocation;

		public searchHotelByCircleRequest(stay s, List<occupancies> o, geolocation g){
			this.stay = s;
			this.occupancies = o;
			this.geolocation = g;
		}
	}

	public class searchHotelByHotelListRequest{
		public stay stay;
		public List<occupancies> occupancies;
		public hotels hotels;

		public searchHotelByHotelListRequest(stay s, List<occupancies> o, hotels h){
			this.stay = s;
			this.occupancies = o;
			this.hotels = h;
		}
	}

	public class searchHotelByDestinationRequest{
		public stay stay;
		public List<occupancies> occupancies;
		public destination destination;

		public searchHotelByDestinationRequest(stay s, List<occupancies> o, destination d){
			this.stay = s;
			this.occupancies = o;
			this.destination = d;
		}
	}

	public class responceHotel{
		public string name;
		public string code;
		public string category;
		public string latitude;
		public string longitude;
		public string minRate;
		public string maxRate;
		public string currency_x;

		public responceHotel(string na, string co, string ca, string la, string lo, string minR, string maxR, string cx){
			this.name = na;
			this.code = co;
			this.category = ca;
			this.latitude = la;
			this.longitude = lo;
			this.minRate = minR;
			this.maxRate = maxR;
			this.currency_x = cx;
		}

	}

	public class responceRoom{
		public string name;
		public string code;
		public string checkIn;
		public string checkOut;
		public string allotment;
		public string sellingRate;
		public string adults;
		public string children;
		public responceHotel responceHotel;

		public responceRoom(string na, string co, string cIn, string cOut, string al, string sr, string ad, string ch, responceHotel rh){
			this.name = na;
			this.code = co;
			this.checkIn = cIn;
			this.checkOut = cOut;
			this.allotment = al;
			this.sellingRate = sr;
			this.adults = ad;
			this.children = ch;
			this.responceHotel = rh;
		} 	
	}

	public class HotelResult{
		public string name;
		public string code;
		public string latitude;
		public string longitude;
		public Decimal HotelMaxAllowedSingle;
		public Decimal HotelMaxAllowedDouble;
		public Decimal HotelMaxAllowedTriple;
		public Decimal HotelMaxAllowedQuad;
		public Set<Date> avaliableDatesSingle;
		public Set<Date> avaliableDatesDouble;
		public Set<Date> avaliableDatesTriple;
		public Set<Date> avaliableDatesQuad;
		public String SingleRoomName;
		public String DoubleRoomName;
		public String TripleRoomName;
		public String QuadRoomName;
		public Decimal minRateSingle;
		public Decimal maxRateSingle;
		public Decimal minRateDouble;
		public Decimal maxRateDouble;
		public Decimal minRateTriple;
		public Decimal maxRateTriple;
		public Decimal minRateQuad;
		public Decimal maxRateQuad;
		public Set<String> facilities;
		public Decimal rating;
		public String stars;

		public HotelResult(){

		}
	}

	public static List<stay> getTimePeriods(stay initialStay){
		Map<String, String> timePeriods = new Map<String, String>();
		List<String> dateOrder = new List<String>();
		List<stay> toReturn = new List<stay>(); 
		
		Date fDate = date.valueOf(initialStay.checkIn);
		Date eDate = date.valueOf(initialStay.checkOut);

		while (fDate < eDate){
			dateOrder.add(String.ValueOf(fDate));
			timePeriods.put(String.ValueOf(fDate), eDate>=fDate.adddays(30) ? String.ValueOf(fDate.adddays(30)) : String.ValueOf(eDate));
			fDate = fDate.addDays(30);
		}
		
		for(String fd:dateOrder){
			toReturn.add(new stay(fd, timePeriods.get(fd), '1'));
		}

		return toReturn;
	}

	public static List<List<occupancies>> getDefaultParametres(){
		paxes adult = new paxes('AD', '30');
		paxes child = new paxes('CH', '8');

		List<paxes> oneAdult = new List<paxes>();
		List<paxes> twoAdults = new List<paxes>();
		List<paxes> twoAdultsOneChild = new List<paxes>();
		List<paxes> twoAdultsTwoChilds = new List<paxes>();
		oneAdult.add(adult);
		twoAdults.add(adult);twoAdults.add(adult);
		twoAdultsOneChild.add(adult);twoAdultsOneChild.add(adult);twoAdultsOneChild.add(child);
		twoAdultsTwoChilds.add(adult);twoAdultsTwoChilds.add(adult);twoAdultsTwoChilds.add(child);twoAdultsTwoChilds.add(child);

		List<occupancies> oneAdultOccupancy = new List<occupancies>();
		oneAdultOccupancy.add(new occupancies('1','1','0',oneAdult));

		List<occupancies> twoAdultsOccupancy = new List<occupancies>();
		twoAdultsOccupancy.add(new occupancies('1','2','0',twoAdults));

		List<occupancies> twoAdultsOneChildOccupancy = new List<occupancies>();
		twoAdultsOneChildOccupancy.add(new occupancies('1','2','1',twoAdultsOneChild));

		List<occupancies> twoAdultsTwoChildsOccupancy = new List<occupancies>();
		twoAdultsTwoChildsOccupancy.add(new occupancies('1','2','2',twoAdultsTwoChilds));

		List<List<occupancies>> occupanciesList = new List<List<occupancies>>();

		occupanciesList.add(oneAdultOccupancy);
		//occupanciesList.add(twoAdultsOccupancy);
		//occupanciesList.add(twoAdultsOneChildOccupancy);
		//occupanciesList.add(twoAdultsTwoChildsOccupancy);

		return occupanciesList;
	}
	

	public static void sleep(Integer sleepSeconds) {
	    Long startTS = System.currentTimeMillis();
	    HttpRequest req = new HttpRequest();
	    req.setEndpoint('http://1.cuzillion.com/bin/resource.cgi?sleep=' + sleepSeconds);
	    req.setMethod('GET');
	    req.setTimeout(5000);
	    Http http = new Http();
	    HTTPResponse res = http.send(req);
	    Long duration = System.currentTimeMillis() - startTS;
	    System.debug('Duration: ' + duration + 'ms');
	}

	public static String processData(stay initialStay, geolocation ge, List<HackathonTestMainWindowController.IndividualInfo> individualGuestInfo){
		
		//svd2m5h29ru2gkarysyesphw KNXsBYdUf9 - default
		//89n8tuc2zy7bpyg946b2ssb8 jt5FGBZ3Wq - secondary
		//6qbjpwx9mzdnvw29jkd9gug4 PgXPFvcUjb - ivan

		Integer initialStayDays = Date.ValueOf(initialStay.checkIn).daysBetween(Date.ValueOf(initialStay.checkOut));

		Map<String, String> responceMap = new Map<String,String>();
		for(stay st:getTimePeriods(initialStay)){
			for(List<occupancies> oc:getDefaultParametres()){
				String key = st.checkIn + ':' + st.checkOut + ':' + oc.get(0).rooms + oc.get(0).adults + oc.get(0).children;
				responceMap.put(key, HotelSearch('svd2m5h29ru2gkarysyesphw', 'KNXsBYdUf9', st, oc, ge, null, null));
				sleep(1);
			}
		}
		system.debug('responceMap: ' + responceMap.size());
		for(string key:responceMap.keySet()){
			system.debug(key + ' : ' + responceMap.get(key));
		}
		
		return parseResponceData(responceMap, individualGuestInfo, initialStayDays, ge);
	}

	public static String parseResponceData(Map<String,String> auditData, List<HackathonTestMainWindowController.IndividualInfo> individualGuestInfo, Integer initialStayDays, geolocation ge){
		List<HackatonHotelsBedResponseWrapper.ResponceWrapper> hbrw = new List<HackatonHotelsBedResponseWrapper.ResponceWrapper>();
		//for production
		
		for(String key:auditData.keySet()){
			String responceJSON = auditData.get(key);
			responceJSON = responceJSON.replace('"currency"', '"currency_x"');
			hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(responceJSON,HackatonHotelsBedResponseWrapper.ResponceWrapper.class));
		}
		

		//for testing
		/*
		String testJson = HackatonHotelsBedResponceMock.Berlin05010531_110;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));
	
		testJson = HackatonHotelsBedResponceMock.Berlin05010531_111;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));

		testJson = HackatonHotelsBedResponceMock.Berlin05010531_121;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));

		testJson = HackatonHotelsBedResponceMock.Berlin05010531_120;
		testJson = testJson.replace('"currency"', '"currency_x"');
		
		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));

		testJson = HackatonHotelsBedResponceMock.Berlin05310630_110;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));

		testJson = HackatonHotelsBedResponceMock.Berlin05310630_111;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));

		testJson = HackatonHotelsBedResponceMock.Berlin05310630_121;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));

		testJson = HackatonHotelsBedResponceMock.Berlin05310630_120;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));
	
		testJson = HackatonHotelsBedResponceMock.Berlin06300730_110;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));

		testJson = HackatonHotelsBedResponceMock.Berlin06300730_111;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));

		testJson = HackatonHotelsBedResponceMock.Berlin06300730_121;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));

		testJson = HackatonHotelsBedResponceMock.Berlin06300730_120;
		testJson = testJson.replace('"currency"', '"currency_x"');

		hbrw.add((HackatonHotelsBedResponseWrapper.ResponceWrapper)JSON.deserialize(testJson, HackatonHotelsBedResponseWrapper.ResponceWrapper.class));
		*/

		List<responceRoom> rrs = new List<responceRoom>();
		for(HackatonHotelsBedResponseWrapper.ResponceWrapper rw: hbrw){
			if(rw.hotels!=null){
				if(rw.hotels.hotels!=null){
					for(HackatonHotelsBedResponseWrapper.hotels h : rw.hotels.hotels){
						responceHotel rh = new responceHotel(h.name, h.code, h.categoryName, h.latitude, h.longitude, h.minRate, h.maxRate, h.currency_x);
						for(HackatonHotelsBedResponseWrapper.rooms room : h.rooms){
							for(HackatonHotelsBedResponseWrapper.rates rate : room.rates){
								if(rate.paymentType == 'AT_WEB'){
									if(rate.shiftRates!=null){
										for(HackatonHotelsBedResponseWrapper.shiftRates shiftRate : rate.shiftRates){
											responceRoom rr = new responceRoom(room.name, room.code, shiftRate.checkIn, shiftRate.checkOut, shiftRate.allotment, shiftRate.sellingRate, rate.adults, rate.children, rh); 
											rrs.add(rr);
										}
									}
								}	
							}	
						}
					}
				}
			}	
		}
		system.debug('rrs.size(): ' + rrs.size());
		return getDailyOccupancy(rrs, individualGuestInfo, initialStayDays, ge);	
	}

	public static String getDailyOccupancy(List<responceRoom> rrs, List<HackathonTestMainWindowController.IndividualInfo> individualGuestInfo, Integer initialStayDays, geolocation ge){
		Set<String> days = new Set<String>();
		Set<String> hotels = new Set<String>();
		Map<String, responceHotel> hotelsMap = new Map<String, responceHotel>();
		Map<String,List<responceRoom>> HotelRoomsByDay = new Map<String,List<responceRoom>>();
		
		Map<String,Decimal> HotelDayMaxAllotmentSingle = new Map<String,Decimal>();
		Map<String,Decimal> HotelDayMaxAllotmentDouble = new Map<String,Decimal>();
		Map<String,Decimal> HotelDayMaxAllotmentTriple = new Map<String,Decimal>();
		Map<String,Decimal> HotelDayMaxAllotmentQuad = new Map<String,Decimal>();

		Map<String, Decimal> HotelMaxAllowedSingle = new Map<String, Decimal>();
		Map<String, Decimal> HotelMaxAllowedDouble = new Map<String, Decimal>();
		Map<String, Decimal> HotelMaxAllowedTriple = new Map<String, Decimal>();
		Map<String, Decimal> HotelMaxAllowedQuad = new Map<String, Decimal>();

		Map<String,Set<Date>> HotelsDatesSingle  = new Map<String,Set<Date>>();
		Map<String,Set<Date>> HotelsDatesDouble  = new Map<String,Set<Date>>();
		Map<String,Set<Date>> HotelsDatesTriple  = new Map<String,Set<Date>>();
		Map<String,Set<Date>> HotelsDatesQuad  = new Map<String,Set<Date>>(); 

		Map<String, String> HotelRoomTypeSingle = new Map<String,String>();
		Map<String, String> HotelRoomTypeDouble = new Map<String,String>();
		Map<String, String> HotelRoomTypeTriple = new Map<String,String>();
		Map<String, String> HotelRoomTypeQuad = new Map<String,String>();

		Map<String, Decimal> HotelRateMinSingle = new Map<String,Decimal>();
		Map<String, Decimal> HotelRateMinDouble = new Map<String,Decimal>();
		Map<String, Decimal> HotelRateMinTriple = new Map<String,Decimal>();
		Map<String, Decimal> HotelRateMinQuad = new Map<String,Decimal>();

		for(responceRoom rr:rrs){
			Date sDate = date.valueOf(rr.checkIn);
			Date eDate = date.valueOf(rr.checkOut);
			hotelsMap.put(rr.responceHotel.Name, rr.responceHotel);
			while(sDate<=eDate){
				string day = String.ValueOf(sDate.year()) + '-' + String.ValueOf(sDate.month()) + '-' + String.ValueOf(sDate.day());
				days.add(day);
				hotels.add(rr.responceHotel.name);
				if(!HotelRoomsByDay.containsKey(day + rr.responceHotel.name)){
					HotelRoomsByDay.put(day + rr.responceHotel.name, new List<responceRoom>());
				}
				HotelRoomsByDay.get(day + rr.responceHotel.name).add(rr);

				if(rr.adults + rr.children == '10'){
					if(!HotelsDatesSingle.containsKey(rr.responceHotel.name)){
						HotelsDatesSingle.put(rr.responceHotel.name, new Set<Date>());
					}
					HotelsDatesSingle.get(rr.responceHotel.name).add(sDate);
				}

				if(rr.adults + rr.children == '20'){
					if(!HotelsDatesDouble.containsKey(rr.responceHotel.name)){
						HotelsDatesDouble.put(rr.responceHotel.name, new Set<Date>());
					}
					HotelsDatesDouble.get(rr.responceHotel.name).add(sDate);
				}

				if(rr.adults + rr.children == '21'){
					if(!HotelsDatesTriple.containsKey(rr.responceHotel.name)){
						HotelsDatesTriple.put(rr.responceHotel.name, new Set<Date>());
					}
					HotelsDatesTriple.get(rr.responceHotel.name).add(sDate);
				}

				if(rr.adults + rr.children == '22'){
					if(!HotelsDatesQuad.containsKey(rr.responceHotel.name)){
						HotelsDatesQuad.put(rr.responceHotel.name, new Set<Date>());
					}
					HotelsDatesQuad.get(rr.responceHotel.name).add(sDate);
				}

				sDate = sDate.addDays(1);
			}
		}

		for(String d:days){
			for(String h:hotels){
				if(HotelRoomsByDay.containsKey(d+h)){
					for(responceRoom rr:HotelRoomsByDay.get(d+h)){

						if(rr.adults + rr.children == '10'){

							if(!HotelMaxAllowedSingle.containsKey(h)){
								HotelMaxAllowedSingle.put(h, Decimal.ValueOf(rr.allotment));
								HotelRoomTypeSingle.put(h, rr.name);
								HotelRateMinSingle.put(h, rr.sellingRate!=null? Decimal.ValueOf(rr.sellingRate):0);
							}else{
								if(HotelMaxAllowedSingle.get(h) > Decimal.ValueOf(rr.allotment)){
									HotelMaxAllowedSingle.put(h, Decimal.ValueOf(rr.allotment));
									HotelRoomTypeSingle.put(h, rr.name);
									HotelRateMinSingle.put(h, rr.sellingRate!=null? Decimal.ValueOf(rr.sellingRate):0);
								}
							}

							if(!HotelDayMaxAllotmentSingle.containsKey(d+h)){
								HotelDayMaxAllotmentSingle.put(d+h, Decimal.ValueOf(rr.allotment));
								
							}else{
								if(Decimal.ValueOf(rr.allotment) > HotelDayMaxAllotmentSingle.get(d+h)){
									HotelDayMaxAllotmentSingle.put(d+h, Decimal.ValueOf(rr.allotment));
								}
								
							}
						}

						if(rr.adults + rr.children == '20'){

							if(!HotelMaxAllowedDouble.containsKey(h)){
								HotelMaxAllowedDouble.put(h, Decimal.ValueOf(rr.allotment));
								HotelRoomTypeDouble.put(h, rr.name);
								HotelRateMinDouble.put(h, rr.sellingRate!=null? Decimal.ValueOf(rr.sellingRate):0);
							}else{
								if(HotelMaxAllowedDouble.get(h) > Decimal.ValueOf(rr.allotment)){
									HotelMaxAllowedDouble.put(h, Decimal.ValueOf(rr.allotment));
									HotelRoomTypeDouble.put(h, rr.name);
									HotelRateMinDouble.put(h, rr.sellingRate!=null? Decimal.ValueOf(rr.sellingRate):0);
								}
							}

							if(!HotelDayMaxAllotmentDouble.containsKey(d+h)){
								HotelDayMaxAllotmentDouble.put(d+h,Decimal.ValueOf(rr.allotment));
							}else{
								if(Decimal.ValueOf(rr.allotment) > HotelDayMaxAllotmentDouble.get(d+h)){
									HotelDayMaxAllotmentDouble.put(d+h, Decimal.ValueOf(rr.allotment));
								}
							}
						}

						if(rr.adults + rr.children == '21'){

							if(!HotelMaxAllowedTriple.containsKey(h)){
								HotelMaxAllowedTriple.put(h, Decimal.ValueOf(rr.allotment));
								HotelRoomTypeTriple.put(h, rr.name);
								HotelRateMinTriple.put(h, rr.sellingRate!=null? Decimal.ValueOf(rr.sellingRate):0);
							}else{
								if(HotelMaxAllowedTriple.get(h) > Decimal.ValueOf(rr.allotment)){
									HotelMaxAllowedTriple.put(h, Decimal.ValueOf(rr.allotment));
									HotelRoomTypeTriple.put(h, rr.name);
									HotelRateMinTriple.put(h, rr.sellingRate!=null? Decimal.ValueOf(rr.sellingRate):0);
								}
							}

							if(!HotelDayMaxAllotmentTriple.containsKey(d+h)){
								HotelDayMaxAllotmentTriple.put(d+h,Decimal.ValueOf(rr.allotment));
							}else{
								if(Decimal.ValueOf(rr.allotment) > HotelDayMaxAllotmentTriple.get(d+h)){
									HotelDayMaxAllotmentTriple.put(d+h, Decimal.ValueOf(rr.allotment));
								}
							}
						}

						if(rr.adults + rr.children == '22'){

							if(!HotelMaxAllowedQuad.containsKey(h)){
								HotelMaxAllowedQuad.put(h, Decimal.ValueOf(rr.allotment));
								HotelRoomTypeQuad.put(h, rr.name);
								HotelRateMinQuad.put(h, rr.sellingRate!=null? Decimal.ValueOf(rr.sellingRate):0);
							}else{
								if(HotelMaxAllowedQuad.get(h) > Decimal.ValueOf(rr.allotment)){
									HotelMaxAllowedQuad.put(h, Decimal.ValueOf(rr.allotment));
									HotelRoomTypeQuad.put(h, rr.name);
									HotelRateMinQuad.put(h, rr.sellingRate!=null? Decimal.ValueOf(rr.sellingRate):0);
								}
							}

							if(!HotelDayMaxAllotmentQuad.containsKey(d+h)){
								HotelDayMaxAllotmentQuad.put(d+h,Decimal.ValueOf(rr.allotment));
							}else{
								if(Decimal.ValueOf(rr.allotment) > HotelDayMaxAllotmentQuad.get(d+h)){
									HotelDayMaxAllotmentQuad.put(d+h, Decimal.ValueOf(rr.allotment));
								}
							}
						}
					}
				}
			}
		} 

		system.debug('HotelMaxAllowedSingle: ' + HotelMaxAllowedSingle);
		system.debug('HotelMaxAllowedDouble: ' + HotelMaxAllowedDouble);
		system.debug('HotelMaxAllowedTriple: ' + HotelMaxAllowedTriple);
		system.debug('HotelMaxAllowedQuad: ' + HotelMaxAllowedQuad);

		for(String hotel:hotels){
			if(HotelsDatesSingle.containsKey(hotel))
				system.debug(hotel + ':' + HotelsDatesSingle.get(hotel).size());
		}
		system.debug('=============');
		for(String hotel:hotels){
			if(HotelsDatesDouble.containsKey(hotel))
				system.debug(hotel + ':' + HotelsDatesDouble.get(hotel).size());
		}
		system.debug('=============');
		for(String hotel:hotels){
			if(HotelsDatesTriple.containsKey(hotel))
				system.debug(hotel + ':' + HotelsDatesTriple.get(hotel).size());
		}


		List<HotelResult> hotelsResults = new List<HotelResult>();
		Integer i = 0;
		for(String h:hotels){	
			HotelResult hr = new HotelResult();
			hr.name = h;
			hr.code = hotelsMap.get(h).code;
			hr.latitude = hotelsMap.get(h).latitude;
			hr.longitude = hotelsMap.get(h).longitude;
			hr.HotelMaxAllowedSingle = (HotelMaxAllowedSingle.get(h)!=null?HotelMaxAllowedSingle.get(h):0);
			hr.HotelMaxAllowedDouble = (HotelMaxAllowedDouble.get(h)!=null?HotelMaxAllowedDouble.get(h):0);
			hr.HotelMaxAllowedTriple = (HotelMaxAllowedTriple.get(h)!=null?HotelMaxAllowedTriple.get(h):0);
			hr.HotelMaxAllowedQuad = (HotelMaxAllowedQuad.get(h)!=null?HotelMaxAllowedQuad.get(h):0);
			hr.avaliableDatesSingle = HotelsDatesSingle.get(h);
			hr.avaliableDatesDouble = HotelsDatesDouble.get(h);
			hr.avaliableDatesTriple = HotelsDatesTriple.get(h);
			hr.avaliableDatesQuad = HotelsDatesQuad.get(h);
			hr.SingleRoomName = HotelRoomTypeSingle.get(h);
			hr.DoubleRoomName = HotelRoomTypeDouble.get(h);
			hr.TripleRoomName = HotelRoomTypeTriple.get(h);
			hr.QuadRoomName = HotelRoomTypeQuad.get(h);
			hr.minRateSingle = HotelRateMinSingle.get(h);
			hr.minRateDouble = HotelRateMinDouble.get(h);
			hr.minRateTriple = HotelRateMinTriple.get(h);
			hr.minRateQuad = HotelRateMinQuad.get(h);
			hr.facilities = (Math.Mod(i,4)==0 ? new Set<String>{} : (Math.Mod(i,4)==1 ? new Set<String>{'pool'} : (Math.Mod(i,4)==2 ? new Set<String>{'parking'} : new Set<String>{'family'})));
			hr.stars = hotelsMap.get(h).category;
			i++;
			hotelsResults.add(hr);
		}

		return lodgeGuests(individualGuestInfo, hotelsResults, initialStayDays, ge);
	
	}

	public static String lodgeGuests(List<HackathonTestMainWindowController.IndividualInfo> individualGuestInfo, List<HotelResult> hotelsResults, Integer initialStayDays, geolocation ge){

		List<HackathonTestMainWindowController.IndividualInfo> vipGuests = new List<HackathonTestMainWindowController.IndividualInfo>();
		List<HackathonTestMainWindowController.IndividualInfo> regularGuests = new List<HackathonTestMainWindowController.IndividualInfo>();
		Map<String, List<HackathonTestMainWindowController.IndividualInfo>> hotelGuest = new Map<String, List<HackathonTestMainWindowController.IndividualInfo>>();
		Map<String, hotelResult> nameHotel = new Map<String, hotelResult>();
		Map<String, Decimal> hotelSingleAvalilbality = new Map<String, Decimal>();
		Map<String, Decimal> hotelDoubleAvalilbality = new Map<String, Decimal>();
		Map<String, Decimal> hotelTripleAvalilbality = new Map<String, Decimal>();
		Map<String, Decimal> hotelQuadAvalilbality = new Map<String, Decimal>();


		for(HotelResult hr: hotelsResults){
			nameHotel.put(hr.name, hr);
			hotelSingleAvalilbality.put(hr.name, hr.HotelMaxAllowedSingle);
			hotelDoubleAvalilbality.put(hr.name, hr.HotelMaxAllowedDouble);
			hotelTripleAvalilbality.put(hr.name, hr.HotelMaxAllowedTriple);
			hotelQuadAvalilbality.put(hr.name, hr.HotelMaxAllowedQuad);
		}
		
		for(HackathonTestMainWindowController.IndividualInfo igi: individualGuestInfo){
			if(igi.vip == 'true'){
				vipGuests.add(igi);
			}else{
				regularGuests.add(igi);
			}
		}

		vipGuests.addAll(regularGuests);
		
		for(HackathonTestMainWindowController.IndividualInfo vg: vipGuests){
			Map<String, List<HotelResult>> fullStayResultList = new Map<String, List<HotelResult>>();
			Map<String, List<HotelResult>> fullStayResultListPrefered = new Map<String, List<HotelResult>>();	
			String type = vg.adults + vg.children;
			for(HotelResult hr:hotelsResults){

				Decimal pointDistance = calculateDistance(Decimal.ValueOf(ge.latitude), Decimal.ValueOf(ge.longitude), Decimal.ValueOf(hr.latitude), Decimal.ValueOf(hr.longitude)) * 1000;

				if((type == '10' && (hr.avaliableDatesSingle.size() >= initialStayDays)) ||
				   (type == '20' && (hr.avaliableDatesDouble.size() >= initialStayDays)) ||
				   (type == '21' && (hr.avaliableDatesTriple.size() >= initialStayDays)) ||
				   (type == '22' && (hr.avaliableDatesQuad.size() >= initialStayDays))){
					Boolean canAdd = false;

					if((Decimal.ValueOf(vg.distMin) <=  pointDistance && pointDistance <= Decimal.ValueOf(vg.distMax))){
						if(type == '10' && hotelSingleAvalilbality.get(hr.name) > 0 && 
							(Decimal.ValueOf(vg.priceMin) <= hr.minRateSingle && hr.minRateSingle <= Decimal.ValueOf(vg.priceMax))){
							canAdd = true;
						}else if(type == '20' && hotelDoubleAvalilbality.get(hr.name) > 0 && (Decimal.ValueOf(vg.priceMin) <= hr.minRateDouble && hr.minRateDouble <= Decimal.ValueOf(vg.priceMax))){
							canAdd = true;
						}else if(type == '21' && hotelTripleAvalilbality.get(hr.name) > 0 && (Decimal.ValueOf(vg.priceMin) <= hr.minRateTriple && hr.minRateTriple <= Decimal.ValueOf(vg.priceMax))){
							canAdd = true;
						}else if(type == '22' && hotelQuadAvalilbality.get(hr.name) > 0 && (Decimal.ValueOf(vg.priceMin) <= hr.minRateQuad && hr.minRateQuad <= Decimal.ValueOf(vg.priceMax))){
							canAdd = true;
						}
					}	
					if(canAdd){
						if(!fullStayResultList.containsKey(vg.name)){
							fullStayResultList.put(vg.name, new List<HotelResult>());
						}
						fullStayResultList.get(vg.name).add(hr);
					}
				}
			}

			if(fullStayResultList!=null){
				if(fullStayResultList.containsKey(vg.name)){
					for(HotelResult hr: fullStayResultList.get(vg.name)){
						if((Boolean.ValueOf(vg.pool) && hr.facilities.contains('pool')) || 
						   (Boolean.ValueOf(vg.parking) && hr.facilities.contains('parking')) ||
						   (Boolean.ValueOf(vg.familyFriendly) && hr.facilities.contains('family'))){
						    if(!fullStayResultListPrefered.containsKey(vg.name)){
								fullStayResultListPrefered.put(vg.name, new List<HotelResult>());
						    }
						    fullStayResultListPrefered.get(vg.name).add(hr);
						}
					}
				}	
			}	


			if(fullStayResultListPrefered.size() > 0  && fullStayResultListPrefered.containsKey(vg.name)){
				if(!hotelGuest.containsKey(fullStayResultListPrefered.get(vg.name).get(0).name)){
					hotelGuest.put(fullStayResultListPrefered.get(vg.name).get(0).name, new List<HackathonTestMainWindowController.IndividualInfo>());
				}
				hotelGuest.get(fullStayResultListPrefered.get(vg.name).get(0).name).add(vg);
				if(type=='10'){
					hotelSingleAvalilbality.put(fullStayResultListPrefered.get(vg.name).get(0).name, hotelSingleAvalilbality.get(fullStayResultListPrefered.get(vg.name).get(0).name) - 1);
				}else if(type=='20'){
					hotelDoubleAvalilbality.put(fullStayResultListPrefered.get(vg.name).get(0).name, hotelDoubleAvalilbality.get(fullStayResultListPrefered.get(vg.name).get(0).name) - 1);
				}else if(type=='21'){
					hotelTripleAvalilbality.put(fullStayResultListPrefered.get(vg.name).get(0).name, hotelTripleAvalilbality.get(fullStayResultListPrefered.get(vg.name).get(0).name) - 1);
				}else if(type=='22'){
					hotelQuadAvalilbality.put(fullStayResultListPrefered.get(vg.name).get(0).name, hotelQuadAvalilbality.get(fullStayResultListPrefered.get(vg.name).get(0).name) - 1);
				}	
			}else{
				if(fullStayResultList!=null){
					if(fullStayResultList.containsKey(vg.name)){
						if(!hotelGuest.containsKey(fullStayResultList.get(vg.name).get(0).name)){
							hotelGuest.put(fullStayResultList.get(vg.name).get(0).name, new List<HackathonTestMainWindowController.IndividualInfo>());
						}
						hotelGuest.get(fullStayResultList.get(vg.name).get(0).name).add(vg);
						if(type=='10'){
							hotelSingleAvalilbality.put(fullStayResultList.get(vg.name).get(0).name, hotelSingleAvalilbality.get(fullStayResultList.get(vg.name).get(0).name) - 1);
						}else if(type=='20'){
							hotelDoubleAvalilbality.put(fullStayResultList.get(vg.name).get(0).name, hotelDoubleAvalilbality.get(fullStayResultList.get(vg.name).get(0).name) - 1);
						}else if(type=='21'){
							hotelTripleAvalilbality.put(fullStayResultList.get(vg.name).get(0).name, hotelTripleAvalilbality.get(fullStayResultList.get(vg.name).get(0).name) - 1);
						}else if(type=='22'){
							hotelQuadAvalilbality.put(fullStayResultList.get(vg.name).get(0).name, hotelQuadAvalilbality.get(fullStayResultList.get(vg.name).get(0).name) - 1);
						}
					}	
				}	
			}
		}

		List<HackathonTestMainWindowController.IndividualInfo> JSONResults = new List<HackathonTestMainWindowController.IndividualInfo>();
		for(String hname:hotelGuest.keySet()){
			for(HackathonTestMainWindowController.IndividualInfo inf:hotelGuest.get(hname)){
				HotelResult hr = nameHotel.get(hname);
				Decimal rateDelte = (((hr.minRateSingle!=null? hr.minRateSingle : 0) - (inf.priceMin!=null ? Decimal.ValueOf(inf.priceMin) : 0))/10);
				hr.rating = 100 - rateDelte - calculateDistance(Decimal.ValueOf(ge.latitude), Decimal.ValueOf(ge.longitude), Decimal.ValueOf(hr.latitude), Decimal.ValueOf(hr.longitude));
				inf.hotelResult = hr;
				JSONResults.add(inf);
			}
		}

		system.debug('JSON.serialize(JSONResults) ' + JSON.serializePretty(JSONResults));
		return JSON.serialize(JSONResults);
	}



	public static Decimal calculateDistance(Decimal lat1, Decimal lon1, Decimal lat2,  Decimal lon2){
      Double Radius = 6371.00;
      Double dLat = toRadians(lat2-lat1);
      Double dLon = toRadians(lon2-lon1);
      Double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
      Math.cos(toRadians(lat1)) *   Math.cos(toRadians(lat2)) *
      Math.sin(dLon/2) * Math.sin(dLon/2);
      Double c = 2 * Math.asin(Math.sqrt(a));
      return Radius * c * .62;
    }


    public static Double toRadians(Decimal degree){
       Double res = degree * 3.1415926 / 180;
       return res;
    }

	public static String HotelSearch(String apiKey, String customerSecret, stay st, List<occupancies> oc, geolocation ge, hotels ho, destination de){
		String JSONRequest;

		if(ge!=null){
			JSONRequest = JSON.serialize(new searchHotelByCircleRequest(st, oc, ge));
		}else if(ho!=null){
			JSONRequest = JSON.serialize(new searchHotelByHotelListRequest(st, oc, ho));
		}else{
			JSONRequest = JSON.serialize(new searchHotelByDestinationRequest(st, oc, de));
		}

		system.debug('JSONRequest: ' + JSONRequest);

		String endpoint = 'https://api.test.hotelbeds.com/hotel-api/1.0/hotels';

		HttpRequest req = new HttpRequest();
		
		//Key svd2m5h29ru2gkarysyesphw
		//Secret KNXsBYdUf9
		String token = (apiKey + customerSecret + System.currentTimeMillis() / 1000);
		Blob tokenBlob = Blob.valueOf(token);
		Blob hashToken = Crypto.generateDigest('SHA-256', tokenBlob);
		String code = EncodingUtil.convertToHex(hashToken);

		req.setHeader('Api-Key', apiKey);
		req.setHeader('Accept-Encoding', 'GZip');
		req.setHeader('X-Signature', code);
		req.setHeader('Content-Type', 'application/json');
		req.setHeader('Accept', 'application/json');

		req.setMethod('POST');
		req.setEndpoint(endpoint);
		req.setBody(JSONRequest);

		Http http = new Http();
		HTTPResponse res = http.send(req);
		System.debug(res.getBody());

		return res.getBody();
	}

}