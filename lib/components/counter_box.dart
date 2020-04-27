import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
export '../home_page.dart';

counterContainer(double height, double width, double margin, IconData icon,
    Color color1, Color color2, int data, String text) {
  return Container(
    // decoration: BoxDecoration(
    //   borderRadius:BorderRadius.circular(20),
    // ),
    height: height * .18,
    width: width,
    margin: EdgeInsets.only(top: margin),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          color: color1,
        ),
        height: height * .18,
        width: width * .45,
        child: Icon(
          icon,
          size: 50,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          color: color2,
        ),
        height: height * .18,
        width: width * .45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                '$data' + '+',
                style: TextStyle(fontSize: 45),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                text,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      )
    ]),
  );
}
