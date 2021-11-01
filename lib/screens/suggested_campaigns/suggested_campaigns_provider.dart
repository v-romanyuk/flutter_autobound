import 'package:Autobound/services/http/http_service.dart';
import 'package:flutter/cupertino.dart';

class SuggestedCampaignsProvider with ChangeNotifier {
  final _campaigns = [
    {"test": "123"},
    {"test": "234"}
  ];

  get campaigns {
    return [..._campaigns];
  }

  Future getSuggestedCampaigns() async {
    final res = (await httpService.get('/suggestedGroups/groupedByTrigger?limit=1000&offset=0')).data;
    print(res);
    return Future.value(res);
  }
}
