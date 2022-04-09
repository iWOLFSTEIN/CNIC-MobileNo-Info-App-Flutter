import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? rewardedAdIdFromFirebase;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  loadRewardedAd() async {
    await RewardedAd.load(
        adUnitId:
            (rewardedAdIdFromFirebase == null || rewardedAdIdFromFirebase == "")
                ? rewardedAdId
                : rewardedAdIdFromFirebase!,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            setState(() {
              this._rewardedAd = ad;
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            setState(() {
              isAdFailedToLoad = true;
            });
          },
        ));
  }

  bool isAdFailedToLoad = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRewardedAdIdFromFirebase();
  }

  getRewardedAdIdFromFirebase() async {
    try {
      await firebaseFirestore
          .collection("AdsIds")
          .doc("rewardedAdId")
          .get()
          .then((value) {
        setState(() {
          rewardedAdIdFromFirebase = value.data()!["id"];
        });
        loadRewardedAd();
      });
    } catch (e) {
      print(e.toString());
    }
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
    if (!isClaimed && _rewardedAd == null) {
      return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (isAdFailedToLoad)
                ? Material(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 6 / 100),
                      child: Container(
                        width: width(context),
                        child: Text(
                          "Ads are not available currently. Come back later!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(),
                        ),
                      ),
                    ),
                  )
                : CircularProgressIndicator(),
            SizedBox(
              height: 30,
            ),
            (isAdFailedToLoad)
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width(context) * 6 / 100),
                    child: Container(
                      width: width(context),
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFFFF2523),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Go Back",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  )
                : Material(
                    child: Text(
                      "Loading Ads...",
                      style: GoogleFonts.roboto(),
                    ),
                  )
          ],
        ),
      );
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
                  onPressed: () async {
                    if (DateTime.parse(databaseProvider.time)
                        .isAfter(DateTime.now())) {
                      showInfoAlert(context,
                          title: "Please wait for your reward!");
                      // databaseProvider.setDayCount(value: 0);
                      // databaseProvider.setTime(
                      //     value: DateTime.now().toString());
                    } else {
                      if (_rewardedAd != null) {
                        _rewardedAd!.show(onUserEarnedReward:
                            (AdWithoutView ad, RewardItem rewardItem) {
                          databaseProvider.setCredits(
                              value: databaseProvider.creditCount +
                                  CoinCalculator.getCoins(
                                      id: databaseProvider.dayCount + 1));
                          databaseProvider.setDayCount(
                              value: databaseProvider.dayCount + 1);
                          databaseProvider.setTime(
                              value: DateTime.now()
                                  .add(Duration(hours: 24))
                                  .toString());
                        });
                      } else {
                        showInfoAlert(context,
                            title:
                                "Ad is not available currently. Come back later!");
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
