import 'package:json_annotation/json_annotation.dart';

part 'verify_code_response.g.dart';

@JsonSerializable()
class VerifyCodeResponse {
  final String? status;

  VerifyCodeResponse({this.status});

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeResponseToJson(this);
}
