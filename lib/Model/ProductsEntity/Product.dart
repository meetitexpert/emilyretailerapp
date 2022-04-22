// ignore_for_file: file_names

import 'package:emilyretailerapp/Model/Entity.dart';
import 'package:emilyretailerapp/Model/PromotionEntity.dart';
import 'package:emilyretailerapp/Model/ProductsEntity/Attributes.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';
import 'package:flutter/foundation.dart';

class Products extends Entity {
  late String categoryIconUrl;
  late int categoryId;
  late String categoryName;
  late int categoryParentId;
  late String descriptionField;
  late String dicountedPrice;
  late String displayPrice;
  late String favourite;
  late int inventory;
  late int soldNumber;
  late String logoUrl;
  late int productId;
  late String productName;
  late String productType;
  late String restrictionTC;
  late String sku;
  late int offerQuantity = 0;
  late bool isGiftCardSelectForSwap = false;
  late PromotionEntity promotion;
  late int productModelId = 0;
  late List<Attributes> attributes = [];
  late List<String> images = [];
  late List<dynamic> variations = [];
  late Map<String, dynamic> appliedVariation;

  Products.fromJson(Map<String, dynamic> json) {
    categoryIconUrl = json["categoryIconUrl"];
    categoryId = json["categoryId"];
    categoryName = json["categoryName"];
    categoryParentId = json["categoryParentId"];
    descriptionField = json["description"];
    dicountedPrice = json["dicountedPrice"];
    displayPrice = json["displayPrice"];
    favourite = json["favourite"] ?? "";
    inventory = json["inventory"];
    soldNumber = json["soldNumber"];
    logoUrl = json["logoUrl"];
    productId = json["productId"];
    productName = json["productName"];
    productType = json["productType"];
    restrictionTC = json["restrictionTC"];
    sku = json["sku"];
    productModelId = json["productModelId"];

    var productImages = json["images"] ?? [];
    if (productImages.length > 0) {
      for (var imageName in productImages) {
        images.add(ConstTools.imageBaseURL + imageName);
      }
    } else {
      images.add(logoUrl);
    }

    var productCatalog = json["productCatalog"] ?? [];
    if (productCatalog.length > 0) {
      var productAttributes = productCatalog["attributes"];
      for (var attribute in productAttributes) {
        debugPrint('$attribute');
        Attributes attr = Attributes.fromJson(attribute);
        attributes.add(attr);
      }

      var varientions = productCatalog["variations"];
      if (variations.isNotEmpty) {
        variations = varientions;
      }
    }
  }
}
