import 'package:flutter/material.dart';

class GaleryScreen extends StatelessWidget {
  const GaleryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Center(
            child: Text(
              'Galery',
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
        body: Container(
          color: Colors.black87,
        ),
      ),
    );
  }
}
