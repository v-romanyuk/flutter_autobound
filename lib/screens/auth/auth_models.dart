import 'package:Autobound/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

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
  final bool success;

  LoginResponse({required this.token, required this.success});

  factory LoginResponse.fromJson(DynamicMap json) => _$LoginResponseFromJson(json);
}

@JsonSerializable()
class UserRole {
  final String name;

  UserRole({required this.name});

  factory UserRole.fromJson(DynamicMap json) => _$UserRoleFromJson(json);
}

@JsonSerializable()
class OrgOwner {
  final String firstName;
  final String lastName;

  OrgOwner({required this.firstName, required this.lastName});

  factory OrgOwner.fromJson(DynamicMap json) => _$OrgOwnerFromJson(json);
}

@JsonSerializable()
class Organization {
  final String companyName;
  final String companyWebsiteUrl;
  final String name;
  final OrgOwner owner;
  final String? updatedAt;
  final bool isInitialContentCopy;
  final String id;
  final int countUsers;
  final String role;

  Organization({
    required this.companyName,
    required this.companyWebsiteUrl,
    required this.name,
    required this.owner,
    required this.isInitialContentCopy,
    required this.id,
    required this.countUsers,
    required this.role,
    this.updatedAt
  });

  factory Organization.fromJson(DynamicMap json) => _$OrganizationFromJson(json);
}

@JsonSerializable()
class UserProfile {
  final bool success;
  final List<String> integrations;
  final String id;
  final String email;
  final String? phone;
  final String? createdAt;
  final String? updatedAt;
  final String? lastLoginAt;
  final String? image;
  final String firstName;
  final String lastName;
  final String companyName;
  final String? jobTitle;
  final String? timeZone;
  final String? meetingLink;
  final String? companyWebsiteUrl;
  final String? signature;
  final List<String> bcc;
  final String? team;
  final bool? isSelfSigned;
  final int onboardingState;
  final int campaignsApproved;
  final List<Organization> organizations;
  final List<String> userEvents;

  UserProfile({
    required this.success,
    required this.integrations,
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.role,
    required this.bcc,
    required this.onboardingState,
    required this.campaignsApproved,
    required this.organizations,
    required this.userEvents,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
    this.image,
    this.jobTitle,
    this.timeZone,
    this.meetingLink,
    this.companyWebsiteUrl,
    this.signature,
    this.team,
    this.isSelfSigned,
  });

  final UserRole role;

  factory UserProfile.fromJson(DynamicMap json) => _$UserProfileFromJson(json);
}
