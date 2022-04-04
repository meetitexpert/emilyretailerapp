// ignore_for_file: file_names

import 'package:emilyretailerapp/Model/CustomerFeedback/CustomersQuestionAnswers.dart';
import 'package:emilyretailerapp/Model/Entity.dart';

class CustomerFeedbackEntity extends Entity {
  late String appId;
  late String memberEmail;
  late String memberFirstName;
  late String memberLastName;
  late List<CustomersQuestionAnswers> questionAnswers;
  late String submitDate;
  late String submitDateTime;
  late String submitTime;
  late String submitTimeStamp;

  CustomerFeedbackEntity.getFromJson(Map<String, dynamic> json) {
    appId = json["appId"];
    memberEmail = json["memberEmail"];
    memberFirstName = json["memberFirstName"];
    memberLastName = json["memberLastName"];
    questionAnswers = [];
    final questionAnswersArray = json["questionAnswers"];
    for (var dic in questionAnswersArray) {
      final value = CustomersQuestionAnswers.fromJson(dic);
      questionAnswers.add(value);
    }

    submitDate = json["submitDate"];
    submitDateTime = json["submitDateTime"];
    submitTime = json["submitTime"];
    submitTimeStamp = json["submitTimeStamp"];
  }
}
