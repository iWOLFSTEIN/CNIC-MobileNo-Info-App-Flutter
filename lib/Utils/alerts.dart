import 'package:flutter/material.dart';

showInfoAlert(context, {required title}) {
  var alert = AlertDialog(
    title: Text(title),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel"))
    ],
  );
  showDialog(
      context: context,
      builder: (context) {
        return alert;
      });
}
