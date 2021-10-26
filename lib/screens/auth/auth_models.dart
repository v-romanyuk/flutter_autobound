import 'package:json_annotation/json_annotation.dart';
import 'package:Autobound/models/models.dart';
part 'auth_models.g.dart';

@JsonSerializable()
class LoginForm implements ToJson {
  String email;
  String password;

  LoginForm({required this.email, required this.password});

  @override
  DynamicMap toJson() => _$LoginFormToJson(this);
}

@JsonSerializable()
class LoginResponse {
  final String token;
  final String status;

  LoginResponse({
    required this.token,
    required this.status
  });

  factory LoginResponse.fromJson(DynamicMap json) => _$LoginResponseFromJson(json);
}
