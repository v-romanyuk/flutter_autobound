import 'package:Autobound/models/models.dart';
import 'package:Autobound/services/http/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class SuggestedCampaignsProvider with ChangeNotifier {
  List<SuggestedCampaignTrigger> _suggestedCampaignTriggers = [];

  get campaigns {
    return [..._suggestedCampaignTriggers];
  }

  Future getSuggestedCampaigns() async {
    try {
      final res = (await httpService.get('/suggestedGroups/groupedByTrigger?limit=1000&offset=0')).data;
      _suggestedCampaignTriggers = SuggestedCampaign.fromJson(res).triggers;
      notifyListeners();
      return Future.value(_suggestedCampaignTriggers);

    } on DioError catch (err) {
      return Future.error(err);
    }
  }
}
