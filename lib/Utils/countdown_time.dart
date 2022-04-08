import 'dart:async';

import 'package:contact_api_info_app/Provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CountdownTimer extends StatefulWidget {
  CountdownTimer({Key? key, this.startDuration}) : super(key: key);

  final startDuration;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? countdownTimer;
  Duration myDuration = Duration(hours: 0);
  @override
  void initState() {
    super.initState();
    myDuration = widget.startDuration;
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        isCancelled = true;
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  bool isCancelled = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    countdownTimer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    if (isCancelled) {
      var databaseProvider = Provider.of<DatabaseProvider>(context);
      databaseProvider.setTime(value: DateTime.now().toString());
    }
    return Text(
      '$hours:$minutes:$seconds',
      style: GoogleFonts.roboto(
          textStyle: TextStyle(color: Colors.white, fontSize: 15)),
    );
  }
}
