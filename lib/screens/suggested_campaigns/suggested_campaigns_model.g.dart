// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggested_campaigns_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestedCampaignTrigger _$SuggestedCampaignTriggerFromJson(
        Map<String, dynamic> json) =>
    SuggestedCampaignTrigger(
      contacts: json['contacts'] as int,
      groups: json['groups'] as int,
      campaigns: json['campaigns'] as int,
      companies: json['companies'] as int,
      name: json['name'] as String,
      score: json['score'] as int,
      id: json['id'] as String,
    );

Map<String, dynamic> _$SuggestedCampaignTriggerToJson(
        SuggestedCampaignTrigger instance) =>
    <String, dynamic>{
      'contacts': instance.contacts,
      'groups': instance.groups,
      'campaigns': instance.campaigns,
      'companies': instance.companies,
      'name': instance.name,
      'score': instance.score,
      'id': instance.id,
    };

SuggestedCampaign _$SuggestedCampaignFromJson(Map<String, dynamic> json) =>
    SuggestedCampaign(
      success: json['success'] as bool,
      count: json['count'] as int,
      triggers: (json['triggers'] as List<dynamic>)
          .map((e) =>
              SuggestedCampaignTrigger.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuggestedCampaignToJson(SuggestedCampaign instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'triggers': instance.triggers,
    };
