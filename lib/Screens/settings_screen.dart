import 'package:contact_api_info_app/Constants/urls.dart';
import 'package:contact_api_info_app/Utils/alerts.dart';
import 'package:contact_api_info_app/Utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key, this.contactSupportUrl, this.privacyPolicyUrl, this.rateAppUrl, this.termsOfServiceUrl}) : super(key: key);

  var privacyPolicyUrl;
  var termsOfServiceUrl;
  var rateAppUrl;
  var contactSupportUrl;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void launchURL(context, {required url}) async {
    try {
      if (!await launch(url)) throw 'Could not launch $url';
    } catch (e) {
      print(e.toString());
      showInfoAlert(context, title: "Network Error!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FE),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width(context) * 6 / 100),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            settingButton(
                title: "Privacy Policy",
                voidCallBack: () {
                  launchURL(context, url: widget.privacyPolicyUrl);
                }),
            SizedBox(
              height: 10,
            ),
            settingButton(
                title: "Terms of Service",
                voidCallBack: () {
                  launchURL(context, url: widget.termsOfServiceUrl);
                }),
            SizedBox(
              height: 10,
            ),
            settingButton(
                title: "Rate App",
                voidCallBack: () {
                  launchURL(context, url: widget.rateAppUrl);
                }),
            SizedBox(
              height: 10,
            ),
            settingButton(
                title: "Contact Support",
                voidCallBack: () {
                  launchURL(context, url: widget.contactSupportUrl);
                }),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Container settingButton({title, voidCallBack}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.075)),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TextButton(
        onPressed: voidCallBack,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
    );
  }
}
