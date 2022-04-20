import 'package:emilyretailerapp/Model/Entity.dart';

class RetailerLocationsDetail {
  var address;
  var city;
  var country;
  var friClose;
  var friEnd;
  var friStart;
  var latitude;
  var logoURL;
  var longitude;
  var message;
  var monClose;
  var monEnd;
  var monStart;
  var phoneNum;
  var postalCode;
  var province;
  var satClose;
  var satEnd;
  var satStart;
  var status;
  var sunClose;
  var sunEnd;
  var sunStart;
  var thuClose;
  var thuEnd;
  var thuStart;
  var tueClose;
  var tueEnd;
  var tueStart;
  var webSite;
  var wedClose;
  var wedEnd;
  var wedStart;

  RetailerLocationsDetail.fromJson(Map<String, dynamic> json) {
    address = json["address"];
    city = json["city"];
    country = json["country"];
    friClose = json["friClose"];
    friEnd = json["friEnd"];
    friStart = json["friStart"];
    latitude = json["latitude"];
    logoURL = json["logoURL"];
    longitude = json["longitude"];
    message = json["message"];
    monClose = json["monClose"];
    monEnd = json["monEnd"];
    monStart = json["monStart"];
    phoneNum = json["phoneNum"];
    postalCode = json["postalCode"];
    province = json["province"];
    satClose = json["satClose"];
    satEnd = json["satEnd"];
    satStart = json["satStart"];
    status = json["status"];
    sunClose = json["sunClose"];
    sunEnd = json["sunEnd"];
    sunStart = json["sunStart"];
    thuClose = json["thuClose"];
    thuEnd = json["thuEnd"];
    thuStart = json["thuStart"];
    tueClose = json["tueClose"];
    tueEnd = json["tueEnd"];
    tueStart = json["tueStart"];
    webSite = json["webSite"];
    wedClose = json["wedClose"];
    wedEnd = json["wedEnd"];
    wedStart = json["wedStart"];
  }
}
