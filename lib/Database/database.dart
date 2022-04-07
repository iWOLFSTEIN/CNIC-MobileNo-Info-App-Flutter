import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database with ChangeNotifier {
  getNewUserState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool alreadyVisited = prefs.getBool('alreadyVisited') ?? true;

    return alreadyVisited;
  }

  setNewUserState({bool? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('alreadyVisited', value!);
    // notifyListeners();
  }

  getCredits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int currentCredits = prefs.getInt("currentCredits") ?? 0;

    return currentCredits;
  }

  setCredits({int? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentCredits', value!);
    // notifyListeners();
  }

  getDayCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int currentDayCount = prefs.getInt("currentDayCount") ?? 0;

    return currentDayCount;
  }

  setDayCount({int? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentDayCount', value!);
  }

  getTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String currentTime = prefs.getString("currentDayCount") ?? "";

    return currentTime;
  }

  setTime({String? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentTime', value!);
  }
}
