import 'package:emilyretailerapp/Model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_root.g.dart';

@JsonSerializable()
class userRoot {

  @JsonKey(name:'data')
  late User user;

  userRoot();

  factory userRoot.fromJson(Map<String, dynamic> json) {
    return _$userRootFromJson(json);
  }

  /// Connect the generated [_$userRootToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$userRootToJson(this);
}