import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class ApiScrappedData {
  getLiveTrackerApiData({required url, required payload}) async {
    // var url = Uri.parse('https://globaldailyinfo.com/search-result-2022.php');
    var response = await http.post(
      url,
      body:payload
      // {'num': number},
    );

    var dataList = [];

    var document = parse(response.body);

    for (var i in document.getElementsByClassName("tg")) {
      var tableDocument = parse(i.innerHtml);
      var tempList = [];
      for (var j in tableDocument.getElementsByTagName("span")) {
        tempList.add(j.innerHtml);
      }
      dataList.add(tempList);
    }
    

    return dataList;
  }
}
