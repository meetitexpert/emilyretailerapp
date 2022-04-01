import 'package:emilyretailerapp/Model/Entity.dart';

class RetailerRewardEntity extends Entity {
  late String appFrontImgURL;
  late int rewardId;
  late String rewardShortDescription;
  late String type;

  RetailerRewardEntity();

  RetailerRewardEntity.fromJson(Map<String, dynamic> json) {
    appFrontImgURL = json["appFrontImgURL"].toString();
    rewardId = json["rewardId"];
    rewardShortDescription = json["rewardShortDescription"].toString();
    type = json["type"].toString();
  }
}
