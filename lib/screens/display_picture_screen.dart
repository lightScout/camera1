import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath1;
  final String imagePath2;

  const DisplayPictureScreen({this.imagePath1, this.imagePath2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Image.file(File(imagePath1)),
          Image.file(File(imagePath2)),
        ],
      ),
    );
  }
}
