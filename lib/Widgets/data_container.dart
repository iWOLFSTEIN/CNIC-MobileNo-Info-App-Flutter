import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/dimensions.dart';

class DataContainer extends StatelessWidget {
  DataContainer({Key? key, this.address, this.cnic, this.name, this.number})
      : super(key: key);

  var number;
  var name;
  var cnic;
  var address;
  Padding dataContainerElement(BuildContext context,
      {required title, required value, required color, required isTitle}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width(context) * 6 / 100),
      child: Row(
        crossAxisAlignment:
            (isTitle) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.orange,
            width: 100,
            child: Text(
              title,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: color, fontSize: 16)),
            ),
          ),
          Expanded(child: Container()),
          Container(
            // color: Colors.blue,
            width: 125,
            child: Text(
              value,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: color, fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: width(context) * 4 / 100,
          right: width(context) * 4 / 100,
          bottom: 15),
      child: Container(
        height: 270,
        width: double.infinity,
        decoration: BoxDecoration(
            // border: Border.all(
            //   color: Color(0xFFFF2523),
            // ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFFF2523),
                  border: Border.all(
                    color: Color(0xFFFF2523),
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: dataContainerElement(context,
                  title: "Number #",
                  value: number,
                  isTitle: true,
                  color: Colors.white),
            ),
            Container(
              height: 218,
              decoration: BoxDecoration(
                  color: Color(0xFFFDECEF),
                  // border: Border(top: BorderSide(color: Colors.yellow)),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  dataContainerElement(context,
                      title: "Name",
                      value: name,
                      isTitle: false,
                      color: Colors.black),
                  SizedBox(
                    height: 10,
                  ),
                  dataContainerElement(context,
                      title: "CNIC #",
                      value: cnic,
                      isTitle: false,
                      color: Colors.black),
                  SizedBox(
                    height: 12.5,
                  ),
                  dataContainerElement(context,
                      title: "Address",
                      value: address,
                      isTitle: false,
                      color: Colors.black),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
