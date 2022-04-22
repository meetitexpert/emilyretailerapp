// ignore_for_file: file_names

class Attributes {
  late int id;
  late String name;
  late String type;
  late String valueType;
  late String selectionType;
  late bool mandatory = false;
  late bool variation = false;
  late String defaultValue;
  late List<String> values = [];
  late int multiValuedAttributeId;

  Attributes.fromJson(Map<String, dynamic> json) {}
}
