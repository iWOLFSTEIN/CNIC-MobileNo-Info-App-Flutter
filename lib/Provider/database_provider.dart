import 'package:contact_api_info_app/Database/database.dart';
import 'package:flutter/cupertino.dart';

class DatabaseProvider with ChangeNotifier {
  DatabaseProvider(this._creditCount, this._isNewUser,this._dayCount, this._time, this.database) {
    fetchAndSetData();
  }

  Database? database;

  int? _creditCount = 0;
  int get creditCount => _creditCount!;

  bool? _isNewUser = false;
  bool get isNewUser => _isNewUser!;

  int? _dayCount = 0;
  int get dayCount => _dayCount!;

  String _time = DateTime.now().toString();
  String get time => _time;

  Future<void> fetchAndSetData() async {
    final currentCreditCount = await database!.getCredits();
    final userState = await database!.getNewUserState();
    final currentDayCount = await database!.getDayCount();
    final currentTime = await database!.getTime();

    _isNewUser = userState;
    _creditCount = currentCreditCount;
    _dayCount = currentDayCount;
    _time = currentTime;
    notifyListeners();
  }

  setCredits({value}) async {
    await database!.setCredits(value: value);
    _creditCount = value;
    notifyListeners();
  }

  setUserState({value}) async {
    await database!.setNewUserState(value: value);
    _isNewUser = value;
    notifyListeners();
  }

  setDayCount({value}) async {
    await database!.setDayCount(value: value);
    _dayCount = value;
    notifyListeners();
  }

  setTime({value}) async {
    await database!.setTime(value: value);
    _time = value;
    notifyListeners();
  }
}
