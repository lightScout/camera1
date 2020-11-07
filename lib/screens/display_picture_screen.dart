import 'dart:io';

import 'package:camera1_app/widgets/build_card.dart';
import 'package:camera1_app/widgets/flippable_box.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  static const String id = 'DisplayPictureScreen';
  final File imageFile;
  final bool isFlipped;

  const DisplayPictureScreen({this.imageFile, this.isFlipped});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FlippableBox(
            back: buildCard(imageFile, 500, 300),
            front: buildCard(null, 200, 200),
          ),
        ],
      ),
    );
  }
}
