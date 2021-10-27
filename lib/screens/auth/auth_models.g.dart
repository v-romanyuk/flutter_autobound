// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginForm _$LoginFormFromJson(Map<String, dynamic> json) => LoginForm(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginFormToJson(LoginForm instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String,
      success: json['success'] as bool
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'success': instance.success
    };
