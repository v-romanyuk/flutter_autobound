import 'package:Autobound/styles/colors.dart';
import 'package:flutter/cupertino.dart';

class SuggestedCampaignCard extends StatelessWidget {
  const SuggestedCampaignCard({Key? key, this.margin}) : super(key: key);

  final EdgeInsets? margin;

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
                child: const Text(
                  'Trigger for Colorado Ro...',
                  style: TextStyle(fontSize: 16, color: AppColors.navy, fontWeight: FontWeight.w500),
                ),
              ),
              const Text(
                '6 contacts / 1 companies / 1 groups',
                style: TextStyle(fontSize: 12, color: AppColors.navy),
              )
            ],
          ),
          Container(
            child: Text('badge'),
          )
        ],
      ),
    );
  }
}
