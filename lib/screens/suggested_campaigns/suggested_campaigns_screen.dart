import 'package:Autobound/providers.dart';
import 'package:Autobound/screens/suggested_campaigns/suggested_campaign_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SuggestedCampaignsScreen extends StatefulWidget {
  const SuggestedCampaignsScreen({Key? key}) : super(key: key);

  static const routeName = '/suggested-campaigns';

  @override
  _SuggestedCampaignsScreenState createState() => _SuggestedCampaignsScreenState();
}

class _SuggestedCampaignsScreenState extends State<SuggestedCampaignsScreen> {
  bool _loading = false;

  void getSuggestedCampaigns () async {
    try {
      setState(() {
        _loading = true;
      });
      await context.read<SuggestedCampaignsProvider>().getSuggestedCampaigns();
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    // getSuggestedCampaigns();
    // context.read<AuthProvider>().logout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final campaigns = context.watch<SuggestedCampaignsProvider>().campaigns;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Suggested Campaigns'),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final item = campaigns[index];

          return SuggestedCampaignCard(
            margin: EdgeInsets.only(top: index > 0 ? 15 : 0),
          );
        },
      ),
    );
  }
}
