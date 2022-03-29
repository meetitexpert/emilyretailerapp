// ignore: file_names
import 'package:emilyretailerapp/EmilyNewtworkService/Entity.dart';

class LoginEntity extends Entity {
  late String userId;
  late String fullName;
  late String companyName;
  late String email;
  late String roleId;
  late String firstName;
  late String lastName;
  late String mobileTel;
  late String locationId;
  late String offerId;
  late String storeLocationId;
  late String logoUrl;
  late String registerStatus;
  late String jwt;
  late String isFa;
  late String faNoticeType;
  late int promotionId;

  LoginEntity.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    companyName = json['company_name'];
    email = json['email'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileTel = json['mobile_tel'];
    locationId = json['location_id'];
    offerId = json['offer_id'];
    storeLocationId = json['store_location_id'];
    logoUrl = json['logo_url'];
    registerStatus = json['register_status'];
    jwt = json['jwt'];
    isFa = json['isFa'];
    faNoticeType = json['faNoticeType'];
    promotionId = json['promotionId'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['role_id'] = this.roleId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_tel'] = this.mobileTel;
    data['location_id'] = this.locationId;
    data['offer_id'] = this.offerId;
    data['store_location_id'] = this.storeLocationId;
    data['logo_url'] = this.logoUrl;
    data['register_status'] = this.registerStatus;
    data['jwt'] = this.jwt;
    data['isFa'] = this.isFa;
    data['faNoticeType'] = this.faNoticeType;
    data['promotionId'] = this.promotionId;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
