import 'package:contact_api_info_app/Database/database.dart';
import 'package:contact_api_info_app/Provider/data_provider.dart';
import 'package:contact_api_info_app/Provider/database_provider.dart';
import 'package:contact_api_info_app/Screens/credit_claim_screen.dart';
import 'package:contact_api_info_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'Database/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DataProvider()),
          ChangeNotifierProvider(create: (context) => Database()),
          ChangeNotifierProxyProvider<Database, DatabaseProvider>(
              create: (context) => DatabaseProvider(
                  0, false, 0, DateTime.now().toString(), Database()),
              update: (context, database, databaseProvider) => DatabaseProvider(
                  databaseProvider!.creditCount,
                  databaseProvider.isNewUser,
                  databaseProvider.dayCount,
                  databaseProvider.time,
                  database)),
        ],
        child:
            //  Builder(
            //   builder: (context) {
            //     return
            MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(),
        )
        //     ;
        //   }
        // ),
        );
  }
}
