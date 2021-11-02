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
      success: json['success'] as bool,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'success': instance.success,
    };

UserRole _$UserRoleFromJson(Map<String, dynamic> json) => UserRole(
      name: json['name'] as String,
    );

Map<String, dynamic> _$UserRoleToJson(UserRole instance) => <String, dynamic>{
      'name': instance.name,
    };

OrgOwner _$OrgOwnerFromJson(Map<String, dynamic> json) => OrgOwner(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$OrgOwnerToJson(OrgOwner instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      companyName: json['companyName'] as String,
      companyWebsiteUrl: json['companyWebsiteUrl'] as String,
      name: json['name'] as String,
      owner: OrgOwner.fromJson(json['owner'] as Map<String, dynamic>),
      isInitialContentCopy: json['isInitialContentCopy'] as bool,
      id: json['id'] as String,
      countUsers: json['countUsers'] as int,
      role: json['role'] as String,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'companyWebsiteUrl': instance.companyWebsiteUrl,
      'name': instance.name,
      'owner': instance.owner,
      'updatedAt': instance.updatedAt,
      'isInitialContentCopy': instance.isInitialContentCopy,
      'id': instance.id,
      'countUsers': instance.countUsers,
      'role': instance.role,
    };

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      success: json['success'] as bool,
      integrations: (json['integrations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      companyName: json['companyName'] as String,
      role: UserRole.fromJson(json['role'] as Map<String, dynamic>),
      bcc: (json['bcc'] as List<dynamic>).map((e) => e as String).toList(),
      onboardingState: json['onboardingState'] as int,
      campaignsApproved: json['campaignsApproved'] as int,
      organizations: (json['organizations'] as List<dynamic>)
          .map((e) => Organization.fromJson(e as Map<String, dynamic>))
          .toList(),
      userEvents: (json['userEvents'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      phone: json['phone'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      lastLoginAt: json['lastLoginAt'] as String?,
      image: json['image'] as String?,
      jobTitle: json['jobTitle'] as String?,
      timeZone: json['timeZone'] as String?,
      meetingLink: json['meetingLink'] as String?,
      companyWebsiteUrl: json['companyWebsiteUrl'] as String?,
      signature: json['signature'] as String?,
      team: json['team'] as String?,
      isSelfSigned: json['isSelfSigned'] as bool?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'success': instance.success,
      'integrations': instance.integrations,
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'lastLoginAt': instance.lastLoginAt,
      'image': instance.image,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'companyName': instance.companyName,
      'jobTitle': instance.jobTitle,
      'timeZone': instance.timeZone,
      'meetingLink': instance.meetingLink,
      'companyWebsiteUrl': instance.companyWebsiteUrl,
      'signature': instance.signature,
      'bcc': instance.bcc,
      'team': instance.team,
      'isSelfSigned': instance.isSelfSigned,
      'onboardingState': instance.onboardingState,
      'campaignsApproved': instance.campaignsApproved,
      'organizations': instance.organizations,
      'userEvents': instance.userEvents,
      'role': instance.role,
    };
