import 'package:contact_api_info_app/Screens/cnic_data_screen.dart';
import 'package:contact_api_info_app/Screens/mobile_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with
        // AutomaticKeepAliveClientMixin<HomeScreen>,
        SingleTickerProviderStateMixin {
  // @override
  // bool get wantKeepAlive => true;

  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        GoogleFonts.roboto(textStyle: TextStyle(fontSize: 18));
    return Scaffold(
        backgroundColor: Color(0xFFF7F8FE),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Color(0xFFF7F8FF),
                child: TabBar(
                    controller: tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Color(0xFF96979A),
                    indicatorColor: Color(0xFFFF2523),
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 17.5, top: 17.5),
                        child: Text(
                          "CNIC",
                          style: textStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 17.5, top: 17.5),
                        child: Text(
                          "Mobile",
                          style: textStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 17.5, top: 17.5),
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
                    CnicDataScreen(),
                   MobileDataScreen(),
                    Container(
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
