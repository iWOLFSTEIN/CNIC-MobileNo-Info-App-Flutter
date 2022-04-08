import 'dart:async';

import 'package:contact_api_info_app/Constants/ads_ids.dart';
import 'package:contact_api_info_app/Provider/database_provider.dart';
import 'package:contact_api_info_app/Utils/alerts.dart';
import 'package:contact_api_info_app/Utils/coins_calculator.dart';
import 'package:contact_api_info_app/Utils/countdown_time.dart';
import 'package:contact_api_info_app/Utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class CreditClaimScreen extends StatefulWidget {
  CreditClaimScreen({Key? key}) : super(key: key);

  @override
  State<CreditClaimScreen> createState() => _CreditClaimScreenState();
}

class _CreditClaimScreenState extends State<CreditClaimScreen> {
  RewardedAd? _rewardedAd;

  loadRewardedAd() async {
    await RewardedAd.load(
        adUnitId: rewardedAdId,
        //RewardedAd.testAdUnitId,
        // 'ca-app-pub-3940256099942544/5224354917',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            this._rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRewardedAd();

  }

  

  @override
  Widget build(BuildContext context) {
    var databaseProvider = Provider.of<DatabaseProvider>(context);
 
    bool isClaimed =
        DateTime.parse(databaseProvider.time).isAfter(DateTime.now());
    int currentDayCount = databaseProvider.dayCount;
    if (!isClaimed && currentDayCount == 7) {
      databaseProvider.setDayCount(value: 0);
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width(context) * 7 / 100),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Your Credit: ${databaseProvider.creditCount}",
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Color(0xFF555353),
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 175,
                // color: Colors.orange,
                child: GridView.count(
                  crossAxisCount: 4,
                  children: [
                    for (int i = 1; i <= 7; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (i <= currentDayCount)
                            ? Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFF2523),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "DAY ${i}",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                        Text(
                                          "${CoinCalculator.getCoins(id: i)} COINS",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Center(
                                        child: Text(
                                      "CLAIMED",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9)),
                                    )),
                                  ),
                                ],
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFFF2523),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "DAY ${i}",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300)),
                                    ),
                                    Text(
                                      "${CoinCalculator.getCoins(id: i)} COINS",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300)),
                                    ),
                                  ],
                                ),
                              ),
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 45,
                width: width(context) * 42.5 / 100,
                decoration: BoxDecoration(
                    color: Color(0xFFFF2523),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                  onPressed: () {
                    
                   if (DateTime.parse(databaseProvider.time)
                        .isAfter(DateTime.now())) {
                      showInfoAlert(context,
                          title: "Please wait for your reward!");
                      // databaseProvider.setDayCount(value: 0);
                      // databaseProvider.setTime(
                      //     value: DateTime.now().toString());
                      // databaseProvider.setCredits(value: 0);
                    } else {
                      if (_rewardedAd != null) {
                      _rewardedAd!.show(
                          onUserEarnedReward:
                              (AdWithoutView ad, RewardItem rewardItem) {
                                 databaseProvider.setCredits(
                          value: databaseProvider.creditCount +
                              CoinCalculator.getCoins(
                                  id: databaseProvider.dayCount + 1));
                      databaseProvider.setDayCount(
                          value: databaseProvider.dayCount + 1);
                      databaseProvider.setTime(
                          value: DateTime.now()
                              .add(Duration(hours:24))
                              .toString());
                              });
                    } else {
                      showInfoAlert(context,
                          title: "Ad is not available currently!");
                    }
                     
                    }
                  },
                  child: (isClaimed)
                      ? CountdownTimer(
                          startDuration: DateTime.parse(databaseProvider.time)
                              .difference(DateTime.now()),
                        )
                      : Text(
                          "Claim Reward",
                          style: GoogleFonts.roboto(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
