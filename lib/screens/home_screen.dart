import 'package:camera1_app/cubit/camera1_cubit.dart';
import 'package:camera1_app/others/constants.dart';
import 'package:camera1_app/screens/take_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color appBarColor = Colors.orange;
  final Color mainContainerColor = Color(0xFF8C86AA);
  final bool isGaleryEmpry = true;

  Widget float1() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Color(0xFF9FBBA3),
        heroTag: 'galery',
        onPressed: () {
          Navigator.of(context).pushNamed(TakePictureScreen.id);
        },
        tooltip: 'Second button',
        child: Icon(
          Icons.camera,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Color(0xFFB2EF9B),
        heroTag: 'camera',
        onPressed: null,
        tooltip: 'Third button',
        child: Icon(Icons.camera_roll, color: Colors.black),
      ),
    );
  }

  Widget float3() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Color(0xFFC6E872),
        heroTag: 'settings',
        onPressed: null,
        tooltip: 'First button',
        child: Icon(Icons.settings, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: AnimatedFloatingActionButton(
            //Fab list
            fabButtons: <Widget>[float1(), float2(), float3()],
            colorStartAnimation: Color(0xFF7E3F8F),
            colorEndAnimation: Color(0xFF81559B),
            animatedIconData: AnimatedIcons.menu_close //To principal button
            ),
      ),

      // appBar: AppBar(
      //   elevation: 4,
      //   backgroundColor: appBarColor,
      //   title: Center(
      //       child: Text(
      //     'C2',
      //     style: KSplashScreen.copyWith(fontSize: 22),
      //   )),
      // ),
      body: Container(
        color: mainContainerColor,
        child: isGaleryEmpry
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'C2',
                        style: KSplashScreen.copyWith(color: Colors.grey[900]),
                      )
                    ],
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: ListView(
                        children: [],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => {},
            ),
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
      width: 180,
      height: 180,
      decoration: ShapeDecoration(
        color: Color(0xFF122D3F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          side: BorderSide(
            width: 3,
            color: Color(0xFFEDDDB6),
          ),
        ),
      ),
      child: Icon(
        icon,
        color: Color(0xFFCFA33D),
        size: 88,
      ),
    ),
  );
}
