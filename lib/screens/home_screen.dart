import 'package:camera1_app/screens/take_picture_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.black87,
        title: Center(
            child: Icon(
          Icons.adjust,
          size: 50,
          color: Colors.grey[850],
        )),
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(TakePictureScreen.id);
                    },
                    child: homeSelecionButton(Icons.camera)),
                homeSelecionButton(Icons.camera_roll)
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget homeSelecionButton(IconData icon) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      width: 150,
      height: 150,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(
            width: 4,
            color: Colors.grey[400],
          ),
        ),
      ),
      child: Icon(
        icon,
        color: Colors.grey,
        size: 88,
      ),
    ),
  );
}
