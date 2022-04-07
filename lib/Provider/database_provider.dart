import 'package:contact_api_info_app/Database/database.dart';
import 'package:flutter/cupertino.dart';

class DatabaseProvider with ChangeNotifier {
  DatabaseProvider(this._creditCount, this._isNewUser, this.database) {
    fetchAndSetData();
  }

  Database? database;

  int? _creditCount = 0;
  int get creditCount => _creditCount!;

  bool? _isNewUser = false;
  bool get isNewUser => _isNewUser!;

  Future<void> fetchAndSetData() async {
    final currentCreditCount = await database!.getCredits();
    final userState = await database!.getNewUserState();

    _isNewUser = userState;
    _creditCount = currentCreditCount;
    notifyListeners();
  }

  setCredits({value}) async {
    await database!.setCredits(value: value);
    _creditCount = value;
    // fetchAndSetData();
    notifyListeners();
  }

  setUserState({value}) async {
    await database!.setNewUserState(value: value);
    _isNewUser = value;
    // fetchAndSetData();
    notifyListeners();
  }
}
