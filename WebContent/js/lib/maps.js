var marker;
var infoWindow;
var geocoder = new google.maps.Geocoder();
var map = null;
var lat;
var lon;

function mapInit(latInput, lonInput) {
	var mapOptions = {
    	zoom: 16,
    	mapTypeId: google.maps.MapTypeId.ROADMAP,
    	streetViewControl: false,
    	panControl: false,
        mapTypeControl: true, 
        mapTypeControlOptions: { 
          style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR, 
          position: google.maps.ControlPosition.BOTTOM_CENTER
        },
        zoomControl: true,
        zoomControlOptions: {
          style: google.maps.ZoomControlStyle.SMALL,
          position: google.maps.ControlPosition.LEFT_CENTER
        }
      };
  
     map = new google.maps.Map(document.getElementById('map'), mapOptions);
     //document.getElementById('map').style("position: relative; background-color: rgb(229, 227, 223); overflow-x: hidden; overflow-y: hidden; -webkit-transform: translateZ(0px); ");
	/*var adUnitDiv = document.createElement('div');
	 var adsense = "ca-pub-3152670624293746";
	   
	 var adUnitOptions = {
	 format: google.maps.adsense.AdFormat.BUTTON,
	     position: google.maps.ControlPosition.RIGHT_BOTTOM,
	     publisherId: adsense,
	     map: map,
	     visible: true
	 };

	 var adUnit = new google.maps.adsense.AdUnit(adUnitDiv, adUnitOptions);*/
	
	 if (latInput == "" && lonInput == ""){
	 	lat = 37.41954708018655;
	 	lon = -122.08398342132568;
	 	if(navigator.geolocation) {
			 navigator.geolocation.getCurrentPosition(function(position){
				 lat = position.coords.latitude;
				    lon = position.coords.longitude;
				    showLatLon(lat, lon);
			 },null, {enableHighAccuracy:true,timeout:200000});
		 }
	 }else {
		 lat = latInput;
		 lon = lonInput;
	 }
	 var latLng = new google.maps.LatLng(lat, lon);
	 map.setCenter(latLng);
	 marker = new google.maps.Marker({
		 position: latLng,
		 title: 'Drag this pin to another location',
		 animation: google.maps.Animation.DROP,
		 map: map,
		 draggable: true
	 });
	 infoWindow = new google.maps.InfoWindow({content: "<div class='place'>Drag this pin anywhere on the Google Map to know the approximate address of that point.</div>"
	 });  

	 infoWindow.open(map, marker);
	 google.maps.event.addListener(marker, 'dragend', function() {
		 geocoder.geocode({latLng: marker.getPosition()}, function(responses) {
			 if (responses && responses.length > 0) {
				 var addr1 = ""; var city=""; var state=""; var country=""; var zip="";
				 for (var i=0; i < responses[0].address_components.length;i++){
					 var addrComp = responses[0].address_components[i];
					 if (addrComp.types[0] == "street_number")
						 addr1 = addrComp.long_name;
					 if (addrComp.types[0] == "route"){
						 if (addr1 == ""){
							 addr1= addrComp.long_name;
						 }else {
							 addr1 = addr1 + " " + addrComp.long_name;
						 }
				 	 }
					 if (addrComp.types[0] == "locality")
						 city = addrComp.long_name;
					 if (city == "" && addrComp.types[0] == "administrative_area_level_3")
						 city = addrComp.long_name;
					 if (addrComp.types[0] == "administrative_area_level_1")
						 state = addrComp.short_name;
					 if (addrComp.types[0] == "country")
						 country = addrComp.short_name;
					 if (addrComp.types[0] == "postal_code")
						 zip= addrComp.short_name;
					 
				 }
				 $("#caddr").val(responses[0].formatted_address);
				 $("#latitude").val(marker.getPosition().lat());
				 $("#longitude").val(marker.getPosition().lng());
				 $("#addr1").val(addr1);
				 $("#city").val(city);
				 $("#state").val(state);
				 $("#country").val(country);
				 $("#zip").val(zip);
				 infoWindow.setContent(
				   "<div class='place'>" + responses[0].formatted_address 
				   + "</div>"
			     );
				 infoWindow.open(map, marker);
			 } else {
				 alert('Sorry but Google Maps was unable to determine the address of this location.');
			 }
		 });
		 map.panTo(marker.getPosition());
	 });
	
	google.maps.event.addListener(marker, 'dragstart', function() {
		infoWindow.close(map, marker);
	});
}
      
 // google.maps.event.addDomListener(window, 'load', initialize);

function showAddress(address) {
  if (geocoder) {
	  geocoder.geocode({ 'address': address }, function(results, status) { 
   		if (status == google.maps.GeocoderStatus.OK) { 
   		 var addr1 = ""; var city=""; var state=""; var country=""; var zip="";
		 for (var i=0; i < results[0].address_components.length;i++){
			 var addrComp = results[0].address_components[i];
			 if (addrComp.types[0] == "street_number")
				 addr1 = addrComp.long_name;
			 if (addrComp.types[0] == "route"){
				 if (addr1 == ""){
					 addr1= addrComp.long_name;
				 }else {
					 addr1 = addr1 + " " + addrComp.long_name;
				 }
		 	 }
			 if (addrComp.types[0] == "locality")
				 city = addrComp.long_name;
			 if (city == "" && addrComp.types[0] == "administrative_area_level_3")
				 city = addrComp.long_name;
			 if (addrComp.types[0] == "administrative_area_level_1")
				 state = addrComp.short_name;
			 if (addrComp.types[0] == "country")
				 country = addrComp.short_name;
			 if (addrComp.types[0] == "postal_code")
				 zip= addrComp.short_name;
			 
		 }
           if(results[0].geometry.location_type == "ROOFTOP")
            map.setZoom(18);
           else
            map.setZoom(14);
           map.setCenter(results[0].geometry.location); 
           marker.setPosition(results[0].geometry.location);
           $("#latitude").val(marker.getPosition().lat());
		   $("#longitude").val(marker.getPosition().lng());
			 $("#addr1").val(addr1);
			 $("#city").val(city);
			 $("#state").val(state);
			 $("#country").val(country);
			 $("#zip").val(zip);
           infoWindow.setContent(
              "<div class='place'>" + results[0].formatted_address
              + "</div>"
            );

           infoWindow.open(map, marker);
         } else { 
            alert("We're sorry but '" + address + "' cannot be found on Google Maps. Please try another address.");
         } 
	  });
  	}
  return false;
}
function showLatLon(lat, lon){
	if (geocoder){
		geocoder.geocode({latLng: new google.maps.LatLng(lat, lon)}, function(responses) {
			 if (responses && responses.length > 0) {
				 $("#caddr").val(responses[0].formatted_address);
				 if(responses[0].geometry.location_type == "ROOFTOP")
	                    map.setZoom(18);
	             else
	                    map.setZoom(14);
	             map.setCenter(responses[0].geometry.location); 
	             marker.setPosition(responses[0].geometry.location);
				 var addr1 = ""; var city=""; var state=""; var country=""; var zip="";
				 for (var i=0; i < responses[0].address_components.length;i++){
					 var addrComp = responses[0].address_components[i];
					 if (addrComp.types[0] == "street_number")
						 addr1 = addrComp.long_name;
					 if (addrComp.types[0] == "route"){
						 if (addr1 == ""){
							 addr1= addrComp.long_name;
						 }else {
							 addr1 = addr1 + " " + addrComp.long_name;
						 }
				 	 }
					 if (addrComp.types[0] == "locality")
						 city = addrComp.long_name;
					 if (city == "" && addrComp.types[0] == "administrative_area_level_3")
						 city = addrComp.long_name;
					 if (addrComp.types[0] == "administrative_area_level_1")
						 state = addrComp.short_name;
					 if (addrComp.types[0] == "country")
						 country = addrComp.short_name;
					 if (addrComp.types[0] == "postal_code")
						 zip= addrComp.short_name;
					 
				 }
				 $("#latitude").val(marker.getPosition().lat());
				 $("#longitude").val(marker.getPosition().lng());
				 $("#addr1").val(addr1);
				 $("#city").val(city);
				 $("#state").val(state);
				 $("#country").val(country);
				 $("#zip").val(zip);
				 
				 infoWindow.setContent(
				   "<div class='place'>" + responses[0].formatted_address 
				   + "</div>"
			     );
				 infoWindow.open(map, marker);
			 } else {
				 alert('Sorry but Google Maps was unable to determine the address of this location.');
			 }
		 });
	}
	
}