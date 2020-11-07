import 'package:camera1_app/cubit/camera1_cubit.dart';
import 'package:camera1_app/screens/take_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        backgroundColor: Color(0xFF420e16),
        title: Center(
            child: Icon(
          Icons.adjust,
          size: 50,
          color: Color(0xFF124736),
        )),
      ),
      body: Container(
        color: Color(0xFF420e16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      final camera1Cubit = context.bloc<Camera1Cubit>();
                      camera1Cubit.cameraPreview();
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
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(
            width: 3,
            color: Color(0xFFE14A14),
          ),
        ),
      ),
      child: Icon(
        icon,
        color: Color(0xFF124736),
        size: 88,
      ),
    ),
  );
}
