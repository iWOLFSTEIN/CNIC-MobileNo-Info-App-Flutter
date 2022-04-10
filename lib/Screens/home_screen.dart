import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_api_info_app/Constants/ads_ids.dart';
import 'package:contact_api_info_app/Provider/database_provider.dart';
import 'package:contact_api_info_app/Screens/cnic_data_screen.dart';
import 'package:contact_api_info_app/Screens/mobile_data_screen.dart';
import 'package:contact_api_info_app/Screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String? bannerAdIdFromFirebase;
  var myBannerAd;
  String? api1;
  var api1Payload;
  String? api2;
  String? contactSupportUrl;
  String? termsOfServiceUrl;
  String? rateAppUrl;
  String? privacyPolicyUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, initialIndex: 1, vsync: this);

    myBannerAd = myBanner();
    getBannerAdIdFromFirebase();
    getApiPathsFromFirebase();
    getSettingsUrlsFromFirebase();
  }

  myBanner() => BannerAd(
        adUnitId:
            (bannerAdIdFromFirebase == null || bannerAdIdFromFirebase == "")
                ? bannerAdId
                : bannerAdIdFromFirebase!,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(),
      );

  getBannerAdIdFromFirebase() async {
    try {
      await firebaseFirestore
          .collection("AdsIds")
          .doc("bannerAdId")
          .get()
          .then((value) {
        setState(() {
          bannerAdIdFromFirebase = value.data()!["id"];
        });
        myBannerAd.load();
        adWidget = AdWidget(ad: myBannerAd);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  getApiPathsFromFirebase() async {
    try {
      await firebaseFirestore
          .collection("APIsPaths")
          .doc("api1")
          .get()
          .then((value) {
        setState(() {
          api1 = value.data()!["path"];
          api1Payload = value.data()!["payload"];
        });
      });

      await firebaseFirestore
          .collection("APIsPaths")
          .doc("api2")
          .get()
          .then((value) {
        setState(() {
          api2 = value.data()!["path"];
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  getSettingsUrlsFromFirebase() async {
    try {
      await firebaseFirestore
          .collection("SettingsUrls")
          .doc("urls")
          .get()
          .then((value) {
        setState(() {
          privacyPolicyUrl = value.data()!["privacyPolicy"];
          termsOfServiceUrl = value.data()!["termsOfService"];
          rateAppUrl = value.data()!["rateApp"];
          contactSupportUrl = value.data()!["contactSupport"];
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  AdWidget? adWidget;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var databaseProvider = Provider.of<DatabaseProvider>(context);
    if (databaseProvider.isNewUser) {
      databaseProvider.setUserState(value: false);
      databaseProvider.setCredits(value: 20);
    }
    TextStyle textStyle =
        GoogleFonts.roboto(textStyle: TextStyle(fontSize: 18));
    return Scaffold(
        backgroundColor: Color(0xFFF7F8FE),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Material(
                    color: Color(0xFFF7F8FF),
                    elevation: 16,
                    child: TabBar(
                        controller: tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Color(0xFF96979A),
                        indicatorColor: Color(0xFFFF2523),
                        tabs: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 17.5, top: 17.5),
                            child: Text(
                              "CNIC",
                              style: textStyle,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 17.5, top: 17.5),
                            child: Text(
                              "Mobile",
                              style: textStyle,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 17.5, top: 17.5),
                            child: Text(
                              "Setttings",
                              style: textStyle,
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        CnicDataScreen(
                          api1: api1,
                          api1Payload: api1Payload,
                          api2: api2,
                        ),
                        MobileDataScreen(
                          api1: api1,
                          api1Payload: api1Payload,
                          api2: api2,
                        ),
                        SettingsScreen(
                          privacyPolicyUrl: privacyPolicyUrl,
                          termsOfServiceUrl: termsOfServiceUrl,
                          rateAppUrl: rateAppUrl,
                          contactSupportUrl: contactSupportUrl,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              (adWidget == null)
                  ? Container()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        alignment: Alignment.center,
                        child: adWidget,
                        width: myBannerAd.size.width.toDouble(),
                        height: myBannerAd.size.height.toDouble(),
                      ),
                    ),
            ],
          ),
        ));
  }
}
