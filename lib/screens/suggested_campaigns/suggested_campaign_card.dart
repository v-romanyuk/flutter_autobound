import 'package:Autobound/models/models.dart';
import 'package:Autobound/styles/colors.dart';
import 'package:flutter/cupertino.dart';

class SuggestedCampaignCard extends StatelessWidget {
  const SuggestedCampaignCard({
    Key? key,
    this.margin,
    required this.suggestedCampaignTrigger
  }) : super(key: key);

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
            width: 66,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                // 0px 25px 40px rgba(0, 0, 0, 0.03);
                BoxShadow(
                  color: Color.fromRGBO(126, 126, 126, 0.1),
                  blurRadius: 40,
                  offset: Offset(0, 30), // changes position of shadow
                ),
              ],
            ),
            child: Text(suggestedCampaignTrigger.score.toString(), style: TextStyle(
              color: AppColors.navy.withOpacity(0.4)
            )),
          )
        ],
      ),
    );
  }
}
