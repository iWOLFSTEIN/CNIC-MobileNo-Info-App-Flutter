import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiData {
  
  getCodeApkApiData({required number, required url}) async{
    var apiUrl = Uri.parse(url+"$number");
    var response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(response.statusCode);
      return data;
    }
    return {};

  }
}
