import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier {
  List<Widget> _cnicWidgetList = [];

  List<Widget> get cnicWidgetList => _cnicWidgetList;
  set cnicWidgetList(var value) {
    _cnicWidgetList = value;
    notifyListeners();
  }

  List<Widget> _mobileWidgetList = [];

  List<Widget> get mobileWidgetList => _mobileWidgetList;
  set mobileWidgetList(var value) {
    _mobileWidgetList = value;
    notifyListeners();
  }
}
