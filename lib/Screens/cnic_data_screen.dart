import 'package:contact_api_info_app/Provider/data_provider.dart';
import 'package:contact_api_info_app/Provider/database_provider.dart';
import 'package:contact_api_info_app/Screens/credit_claim_screen.dart';
import 'package:contact_api_info_app/Services/api_scrapped_data.dart';
import 'package:contact_api_info_app/Utils/alerts.dart';
import 'package:contact_api_info_app/Utils/dimensions.dart';
import 'package:contact_api_info_app/Widgets/data_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../Services/api_data.dart';

class CnicDataScreen extends StatefulWidget {
  CnicDataScreen({Key? key}) : super(key: key);

  @override
  State<CnicDataScreen> createState() => _CnicDataScreenState();
}

class _CnicDataScreenState extends State<CnicDataScreen> {
  var cnicFieldController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    var databaseProvider = Provider.of<DatabaseProvider>(context);
    var maxInputLength = 13;
    var errorInfoMessage = "Enter a valid cnic!";
    var textFieldHintText = 'eg. 489821234567';

    return ModalProgressHUD(
      inAsyncCall: isSearching,
      child: Scaffold(
        backgroundColor: Color(0xFFF7F8FE),
        body: Stack(
          children: [
            (listEquals(dataProvider.cnicWidgetList, []))
                ? Container(
                    width: double.infinity,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: height(context) * 21.5 / 100),
                      child: Text(
                        "Note: Try both databases for better results",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Color(0xFF555253), fontSize: 17)),
                      ),
                    ),
                  )
                : Container(
                    // color: Colors.orange,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: height(context) * 21.5 / 100),
                        child: Column(
                          children: dataProvider.cnicWidgetList,
                        ),
                      ),
                    ),
                  ),
            Container(
               height: height(context) * 20.5 / 100,
                color: Color(0xFFF7F8FE),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width(context) * 4 / 100, vertical: 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Daily Credits: ${databaseProvider.creditCount}",
                          style: TextStyle(
                              color: Color(0xFF545252),
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CreditClaimScreen();
                            }));
                          },
                          child: Text(
                            "Earn Credits?",
                            style: TextStyle(
                                color: Color(0xFFFF2523),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // color: Color(0xFFF7F8FE),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextField(
                        controller: cnicFieldController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: textFieldHintText,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        databaseButton(context, title: "Database 1",
                            voidCallBack: () async {
                          if (databaseProvider.creditCount == 0)
                            showInfoAlert(context,
                                title: "Not enough credits!");
                          else if (cnicFieldController.text != "" &&
                              cnicFieldController.text.length ==
                                  maxInputLength) {
                            //  && cnicFieldController.text.length == 13
                            setState(() {
                              isSearching = true;
                            });
                            List<Widget> dummyWidgetList = [];
                            dataProvider.cnicWidgetList = dummyWidgetList;
                            try {
                              ApiScrappedData apiData = ApiScrappedData();
                              var dataList =
                                  await apiData.getLiveTrackerApiData(
                                      number: cnicFieldController.text);
                              // print(dataList);
                              if (dataList !=
                                  null) if (listEquals(dataList, [])) {
                                setState(() {
                                  isSearching = false;
                                });
                                showInfoAlert(context,
                                    title: "Data not available!");
                              } else {
                                List<Widget> widgetsList = [];

                                for (var i in dataList) {
                                  var widget = DataContainer(
                                    number: i[1] ?? "N/A",
                                    name: i[3] ?? "N/A",
                                    cnic: i[5] ?? "N/A",
                                    address: i[7] ?? "N/A",
                                  );
                                  widgetsList.add(widget);
                                }
                                dataProvider.cnicWidgetList = widgetsList;
                                databaseProvider.setCredits(
                                    value: databaseProvider.creditCount - 1);
                                setState(() {
                                  isSearching = false;
                                });
                              }
                            } catch (e) {
                              setState(() {
                                isSearching = false;
                              });
                              print(e.toString());
                              showInfoAlert(context,
                                  title: "Data not available!");
                            }
                          } else {
                            showInfoAlert(context, title: errorInfoMessage);
                          }
                        }),
                        SizedBox(
                          width: width(context) * 4 / 100,
                        ),
                        databaseButton(context, title: "Database 2",
                            voidCallBack: () async {
                          if (databaseProvider.creditCount == 0)
                            showInfoAlert(context,
                                title: "Not enough credits!");
                          else if (cnicFieldController.text != "" &&
                              cnicFieldController.text.length ==
                                  maxInputLength) {
                            //  && cnicFieldController.text.length == 13
                            setState(() {
                              isSearching = true;
                            });
                            List<Widget> dummyWidgetList = [];
                            dataProvider.cnicWidgetList = dummyWidgetList;
                            try {
                              ApiData apiData = ApiData();
                              var dataList = await apiData.getCodeApkApiData(
                                  number: cnicFieldController.text);
                              print(dataList);
                              if (dataList !=
                                  null) if (mapEquals(dataList, {})) {
                                setState(() {
                                  isSearching = false;
                                });
                                showInfoAlert(context,
                                    title: "Data not available!");
                              } else {
                                List<Widget> widgetsList = [];

                                dataList.forEach((i, value) {
                                  var widget = DataContainer(
                                    number: value["MobileNo "] ?? "N/A",
                                    name: value["Name "] ?? "N/A",
                                    cnic: value["CNIC "] ?? "N/A",
                                    address: value["Address "] ?? "N/A",
                                  );
                                  widgetsList.add(widget);
                                });
                                dataProvider.cnicWidgetList = widgetsList;
                                databaseProvider.setCredits(
                                    value: databaseProvider.creditCount - 1);
                                // print(dataProvider.cnicWidgetList.length);
                                setState(() {
                                  isSearching = false;
                                });
                              }
                            } catch (e) {
                              setState(() {
                                isSearching = false;
                              });
                              print("Throwing Error");
                              print(e.toString());
                              showInfoAlert(context,
                                  title: "Data not available!");
                            }
                          } else {
                            showInfoAlert(context, title: errorInfoMessage);
                          }
                        }),
                        Expanded(child: Container()),
                      ],
                    ),
                    // SizedBox(
                    //   height: 25,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container databaseButton(
    BuildContext context, {
    required title,
    required voidCallBack,
  }) {
    return Container(
      height: 50,
      width: width(context) * 30 / 100,
      decoration: BoxDecoration(
          color: Color(0xFFFF2523),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
        onPressed: voidCallBack,
        child: Text(
          title,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(color: Colors.white, fontSize: 17)),
        ),
      ),
    );
  }
}
