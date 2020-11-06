import 'dart:io';

import 'package:flutter/material.dart';

Widget buildCard(File imageFile, double sizeHeight, double sizeWidth) {
  Color bgColor;
  bgColor = Colors.blueAccent;

  return Container(
    decoration: BoxDecoration(
        color: bgColor,
        // border: Border.all(
        //   color: Colors.red[500],
        // ),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    width: sizeWidth,
    height: sizeHeight,
    child: imageFile != null
        ? FittedBox(
            child: Image.file(imageFile),
            fit: BoxFit.cover,
          )
        : Center(
            child: Text(
            '1',
            style: TextStyle(fontSize: 55, fontStyle: FontStyle.italic),
          )),
  );
}
