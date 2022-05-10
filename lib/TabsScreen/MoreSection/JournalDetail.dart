// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emilyretailerapp/Model/Jounral/JounralOrder.dart';
import 'package:emilyretailerapp/Utils/ColorTools.dart';
import 'package:emilyretailerapp/Utils/PixelTools.dart';
import 'package:flutter/material.dart';

Widget journalDetail(BuildContext context, JounralOrder orderDetail) {
  return AlertDialog(
    insetPadding: EdgeInsets.all(10),
    contentPadding: EdgeInsets.zero,
    content: SizedBox(
      width: PixelTools.screenWidth - 10,
      height: PixelTools.screenHeight - 10,
      child: ListView(
        shrinkWrap: false,
        children: [
          HeaderWidget(),
          orderReceiptDetail(orderDetail: orderDetail),
          catalogSettingWidget(orderDetail: orderDetail),
          sepratorWidget(),
          calcluationWidgetSetting(orderDetail: orderDetail),
          sepratorWidget(),
          orderTypeHandlingWidget(orderDetail),
          orderProcessingHandlingWidget(orderDetail),
        ],
      ),
    ),
  );
}

Widget sepratorWidget() {
  return Column(
    children: [
      SizedBox(
        height: 10,
      ),
      Container(
        width: PixelTools.screenWidth,
        height: 1,
        color: ColorTools.bgGrey,
      ),
    ],
  );
}

Widget orderTypeHandlingWidget(JounralOrder orderDetail) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          orderDetail.expressData["expressType"].toString() == "1"
              ? 'Pick up at store'
              : ("Delivery Address: " +
                  orderDetail.expressData["userAddress"].toString()),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Instructions: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Flexible(
                child: Text(
              orderDetail.expressData["userComment"].toString().isEmpty
                  ? 'N/A'
                  : orderDetail.expressData["userComment"].toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              softWrap: true,
            )),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Flexible(
                child: Text(
              'Tap to update status as the order is being fulfilled',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontSize: 14,
              ),
              softWrap: true,
            )),
          ],
        ),
      ],
    ),
  );
}

class calcluationWidgetSetting extends StatelessWidget {
  late JounralOrder orderDetail;
  calcluationWidgetSetting({Key? key, required this.orderDetail})
      : super(key: key);

  double catalulateItemsTotal(List<dynamic> catalogs) {
    double itemsTotalPrice = 0;
    for (var cata in catalogs) {
      double totalAmount = cata["totalAmount"];
      itemsTotalPrice += totalAmount;
    }
    return itemsTotalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Item:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
              if (orderDetail.standardShippingCost != "0.00")
                Text(
                  'Shipping Fee:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              if (orderDetail.freeShippingAmount != "0.00")
                Text(
                  'Free Shipping:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              if (orderDetail.cashDiscountAmount != "0.00")
                Text(
                  'Pay by cash discount:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              if (orderDetail.couponAppliedValue != "0.00")
                Text(
                  'Coupon Applied:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              Text(
                'Total Before Tax:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
              if (orderDetail.orderTotalTax != "0.00")
                Text(
                  'Taxes:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              if (orderDetail.orderGratuityPrice != "0.00")
                Text(
                  'Gratuity:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              if (orderDetail.creditApplied != "0.00")
                Text(
                  'Credits Applied:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              if (orderDetail.giftCardsAppliedValue != "0.00")
                Text(
                  'Gift Cards Applied :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              Text(
                'Order Total:',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${catalulateItemsTotal(orderDetail.catalogsData)}',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14),
              ),
              if (orderDetail.standardShippingCost != "0.00")
                Text(
                  '\$${orderDetail.standardShippingCost}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                ),
              if (orderDetail.freeShippingAmount != "0.00")
                Text(
                  '\$${orderDetail.freeShippingAmount}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                ),
              if (orderDetail.cashDiscountAmount != "0.00")
                Text(
                  '\$${orderDetail.cashDiscountAmount}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                ),
              if (orderDetail.couponAppliedValue != "0.00")
                Text(
                  '\$${orderDetail.couponAppliedValue}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                ),
              Text(
                '\$${orderDetail.ordertotalBeforeTax}',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '\$${orderDetail.orderTotalTax}',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14),
              ),
              if (orderDetail.orderGratuityPrice != "0.00")
                Text(
                  '\$${orderDetail.orderGratuityPrice}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                ),
              if (orderDetail.creditApplied != "0.00")
                Text(
                  '\$${orderDetail.creditApplied}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                ),
              if (orderDetail.giftCardsAppliedValue != "0.00")
                Text(
                  '\$${orderDetail.giftCardsAppliedValue}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                ),
              Text(
                '\$${orderDetail.orderTotalPrice}',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}

Widget orderProcessingHandlingWidget(JounralOrder orderDetail) {
  String acceptTime = orderDetail.expressData["acceptTime"];
  String estimatedDeliveryTime =
      orderDetail.expressData["estimatedDeliveryTime"];
  String receiveTime = orderDetail.expressData["receiveTime"];
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: Row(
      children: [
        Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: true,
            groupValue: acceptTime.isNotEmpty ? true : false,
            onChanged: (value) {
              debugPrint('$value');
            }),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            orderStatusSetting(1, orderDetail),
            style: TextStyle(fontSize: 14),
          ),
        ),
        Flexible(
            child: Image(
                image: AssetImage('images/arrow-next.png'), fit: BoxFit.fill)),
        Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: true,
            groupValue: estimatedDeliveryTime.isNotEmpty ? true : false,
            onChanged: (value) {
              debugPrint('$value');
            }),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            orderStatusSetting(2, orderDetail),
            style: TextStyle(fontSize: 14),
          ),
        ),
        Flexible(
            child: Image(
                image: AssetImage('images/arrow-next.png'), fit: BoxFit.fill)),
        Radio(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            value: true,
            groupValue: receiveTime.isNotEmpty ? true : false,
            onChanged: (value) {
              debugPrint('$value');
            }),
        Text(
          'Done',
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}

String orderStatusSetting(int type, JounralOrder orderDetail) {
  String expresstype = orderDetail.expressData["expressType"];
  String acceptTime = orderDetail.expressData["acceptTime"];
  String estimatedDeliveryTime =
      orderDetail.expressData["estimatedDeliveryTime"];
  String receiveTime = orderDetail.expressData["receiveTime"];
  String pincode = orderDetail.expressData["expressNumber"];

  String status = '';
  switch (type) {
    case 1:
      if (acceptTime.isNotEmpty) {
        status = 'Accepted';
      } else {
        status = 'Accept';
      }

      break;
    case 2:
      if (expresstype == "1") {
        if (estimatedDeliveryTime.isNotEmpty) {
          status = 'Pickup';
        } else {
          status = 'Ready\nfor Pickup';
        }
      } else {
        if (estimatedDeliveryTime.isNotEmpty) {
          status = 'Delivery';
        } else {
          status = 'Ready\nfor Devlivery';
        }
      }
      break;

    default:
  }
  return status;
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            'Order Receipt',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        MaterialButton(
          padding: EdgeInsets.zero,
          minWidth: 10,
          onPressed: (() {
            Navigator.pop(context);
          }),
          child: Icon(
            Icons.cancel,
            size: 25,
          ),
        )
      ],
    );
  }
}

////////////////////////////////ORDER Detail///////////////////////////////
class orderReceiptDetail extends StatelessWidget {
  late JounralOrder orderDetail;
  orderReceiptDetail({Key? key, required this.orderDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order date:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                'Order #:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              if (orderDetail.orderReferenceNo.isNotEmpty &&
                  orderDetail.orderReferenceNo != "N/A")
                Text(
                  'Payment Ref. #:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              Text(
                'Receipt #:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                'Points Earned:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              if (orderDetail.orderRdeemValue.isNotEmpty)
                Text(
                  'Points Redeemed:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              Text(
                'Credit Applied:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderDetail.date_time,
                style: TextStyle(fontSize: 14),
              ),
              Text(
                orderDetail.orderNo,
                style: TextStyle(fontSize: 14),
              ),
              if (orderDetail.orderReferenceNo.isNotEmpty &&
                  orderDetail.orderReferenceNo != "N/A")
                Text(
                  orderDetail.orderReferenceNo,
                  style: TextStyle(fontSize: 14),
                ),
              Text(
                orderDetail.orderReceiptNo,
                style: TextStyle(fontSize: 14),
              ),
              Text(
                orderDetail.earnedPoints,
                style: TextStyle(fontSize: 14),
              ),
              if (orderDetail.orderRdeemValue.isNotEmpty)
                Text(
                  orderDetail.orderRdeemValue,
                  style: TextStyle(fontSize: 14),
                ),
              Text(
                orderDetail.creditApplied,
                style: TextStyle(fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class catalogSettingWidget extends StatelessWidget {
  late JounralOrder orderDetail;
  catalogSettingWidget({Key? key, required this.orderDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(child: Text('')),
            SizedBox(
                width: 50,
                child: Text('QTY',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorTools.applicationColor))),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Text(
                'Amount',
                style: TextStyle(color: ColorTools.applicationColor),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Container(
            color: ColorTools.bgGrey,
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            child: ListView.builder(
                itemCount: orderDetail.catalogsData.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, i) {
                  List<dynamic> appliedAttributes =
                      orderDetail.catalogsData[i]["attributes"];

                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 75,
                            height: 75,
                            child: Image.network(
                                orderDetail.catalogsData[i]["catalogImageUrl"]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              '${orderDetail.catalogsData[i]["catalogName"]}',
                              softWrap: true,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 50,
                            child: Text(
                              '${orderDetail.catalogsData[i]["purchaseQuantity"]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '\$${orderDetail.catalogsData[i]["totalAmount"]}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      if (appliedAttributes.isNotEmpty)
                        Row(
                          children: [
                            Text(
                              getAttributes(appliedAttributes),
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        )
                    ],
                  );
                }),
          ),
        )
      ],
    );
  }

  String getAttributes(List<dynamic> attributes) {
    String appliedAttributes = '';
    for (var attri in attributes) {
      String attributeName = attri["name"];
      String attributeValue = attri["value"];

      if (attributeName.isNotEmpty && attributeValue.isNotEmpty) {
        appliedAttributes =
            appliedAttributes + (attributeName + ": " + attributeValue + "\n");
      }
    }
    return appliedAttributes;
  }
}
