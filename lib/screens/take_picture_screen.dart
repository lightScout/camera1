import 'dart:async';

import 'package:camera/camera.dart';
import 'package:camera1_app/cubit/camera1_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'display_picture_screen.dart';

class TakePictureScreen extends StatefulWidget {
  static const id = 'TakePictureScreen';

  const TakePictureScreen();

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  // Add two variables to the state class to store the CameraController and
  // the Future.
  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<String> onCapture() async {
    var path;
    try {
      path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      await controller.takePicture(path);
      print('path $path');
    } catch (e) {
      print(e);
    }
    return path;
  }

  Widget _cameraTogglesRowWidget() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
            onPressed: _onSwitchCamera,
            icon: Icon(_getCameraLensIcon(lensDirection)),
            label: Text(
                "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}")),
      ),
    );
  }

  void _onSwitchCamera() async {
    selectedCameraIdx =
        selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    _initCameraController(selectedCamera);
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<Camera1Cubit, Camera1State>(
          listener: (context, state) {
            if (state is Camera1Error) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is Camera1Initial) {
              return buildInitialInput(controller, context);
            } else if (state is Camera1FirstPhotoPreview) {
              return buildFirstPhotoPreview(state.photoPath);
            } else {
              // (state is WeatherError)
              return buildInitialInput(controller, context);
            }
          },
        ),
      ),
    );
  }

  Widget buildFirstPhotoPreview(String photoPath) {
    return DisplayPictureScreen(
      imagePath: photoPath,
    );
  }
}

Widget buildInitialInput(CameraController controller, BuildContext context) {
  return _cameraPreviewWidget(controller, context);
}

Widget _cameraPreviewWidget(CameraController controller, BuildContext context) {
  if (controller == null || !controller.value.isInitialized) {
    return const Text(
      'Loading',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  return Column(
    children: [
      AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      ),
      MaterialButton(
        color: Colors.redAccent,
        onPressed: () {
          _takeFirstPhoto(context);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: Colors.deepOrange)),
      ),
    ],
  );
}

void _takeFirstPhoto(BuildContext context) {
  final camera1Cubit = context.bloc<Camera1Cubit>();
  camera1Cubit.takeFirstPhoto();
}

// Scaffold(
// body: Container(
// child: Column(
// children: [
// _cameraPreviewWidget(),
// _cameraTogglesRowWidget(),
// ],
// ),
// ),
// floatingActionButton: FloatingActionButton(
// child: Icon(Icons.camera_alt),
// // Provide an onPressed callback.
// onPressed: () {
// _onCapturePressed(context);
// },
// ),
// );

// else if (state is CorLoaded) {
// return GestureDetector(
// onTap: () => setState(() => _isFlipped = !_isFlipped),
// child: buildColumnWithData(state.map, _isFlipped));
// }
