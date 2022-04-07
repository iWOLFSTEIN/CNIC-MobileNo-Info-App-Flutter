import 'package:contact_api_info_app/Utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditClaimScreen extends StatefulWidget {
  CreditClaimScreen({Key? key}) : super(key: key);

  @override
  State<CreditClaimScreen> createState() => _CreditClaimScreenState();
}

class _CreditClaimScreenState extends State<CreditClaimScreen> {
  @override
  Widget build(BuildContext context) {
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
                "Your Credit: 2",
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
                    for (int i = 0; i < 7; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height: 5,
                          decoration: BoxDecoration(
                              color: Color(0xFFFF2523),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "DAY 1",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300)),
                              ),
                              Text(
                                "10 COINS",
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
                  onPressed: () {},
                  child: Text(
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
