// ignore_for_file: file_names

class CustomersQuestionAnswers {
  late String answerType;
  late String answerValue = "0";

  CustomersQuestionAnswers.fromJson(Map<String, dynamic> json) {
    answerType = json["answerType"];
    answerValue = json["answerValue"];
  }
}
