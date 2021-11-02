import 'package:Autobound/models/models.dart';
import 'package:Autobound/styles/colors.dart';
import 'package:flutter/cupertino.dart';

class SuggestedCampaignCard extends StatelessWidget {
  const SuggestedCampaignCard({Key? key, this.margin, required this.suggestedCampaignTrigger}) : super(key: key);

  final EdgeInsets? margin;
  final SuggestedCampaignTrigger suggestedCampaignTrigger;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: margin,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          // 0px 25px 40px rgba(0, 0, 0, 0.03);
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.03),
            blurRadius: 40,
            offset: Offset(0, 25), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Text(
                  suggestedCampaignTrigger.name,
                  style: const TextStyle(fontSize: 16, color: AppColors.navy, fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                '${suggestedCampaignTrigger.contacts} contacts / ${suggestedCampaignTrigger.companies} companies / ${suggestedCampaignTrigger.groups} groups',
                style: const TextStyle(fontSize: 12, color: AppColors.navy),
              )
            ],
          ),
          Container(
            width: 67,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
            // 0px 30px 40px rgba(126, 126, 126, 0.1);
                  color: Color.fromRGBO(126, 126, 126, 0.1),
                  blurRadius: 30,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 12,
                  margin: const EdgeInsets.only(right: 7),
                  child: Image.asset('lib/assets/images/app-icon.png'),
                ),
                Text(
                  suggestedCampaignTrigger.score.toDouble().toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.navy.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
