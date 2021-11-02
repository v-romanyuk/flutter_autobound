import 'package:json_annotation/json_annotation.dart';
import 'package:Autobound/models/models.dart';
part 'suggested_campaigns_model.g.dart';

@JsonSerializable()
class SuggestedCampaignTrigger {
  final int contacts;
  final int groups;
  final int campaigns;
  final int companies;
  final String name;
  final int score;
  final String id;

  SuggestedCampaignTrigger({
    required this.contacts,
    required this.groups,
    required this.campaigns,
    required this.companies,
    required this.name,
    required this.score,
    required this.id
  });

  factory SuggestedCampaignTrigger.fromJson(DynamicMap json) => _$SuggestedCampaignTriggerFromJson(json);
}

@JsonSerializable()
class SuggestedCampaign {
  final bool success;
  final int count;
  final List<SuggestedCampaignTrigger> triggers;

  SuggestedCampaign({
    required this.success,
    required this.count,
    required this.triggers
  });

  factory SuggestedCampaign.fromJson(DynamicMap json) => _$SuggestedCampaignFromJson(json);
}
