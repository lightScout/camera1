import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera1_app/cubit/camera1_cubit.dart';
import 'package:camera1_app/widgets/build_card.dart';
import 'package:camera1_app/widgets/flippable_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TakePictureScreen extends StatefulWidget {
  static const id = 'TakePictureScreen';

  const TakePictureScreen();

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  List cameras;
  int selectedCameraIdx;

  // Widget _cameraTogglesRowWidget() {
  //   if (cameras == null || cameras.isEmpty) {
  //     return Spacer();
  //   }
  //
  //   CameraDescription selectedCamera = cameras[selectedCameraIdx];
  //   CameraLensDirection lensDirection = selectedCamera.lensDirection;
  //
  //   return Expanded(
  //     child: Align(
  //       alignment: Alignment.centerLeft,
  //       child: FlatButton.icon(
  //           onPressed: onSwitchCamera,
  //           icon: Icon(_getCameraLensIcon(lensDirection)),
  //           label: Text(
  //               "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}")),
  //     ),
  //   );
  // }

  // IconData _getCameraLensIcon(CameraLensDirection direction) {
  //   switch (direction) {
  //     case CameraLensDirection.back:
  //       return Icons.camera_rear;
  //     case CameraLensDirection.front:
  //       return Icons.camera_front;
  //     case CameraLensDirection.external:
  //       return Icons.camera;
  //     default:
  //       return Icons.device_unknown;
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   availableCameras().then((availableCameras) {
  //     cameras = availableCameras;
  //     if (cameras.length > 0) {
  //       setState(() {
  //         selectedCameraIdx = 0;
  //       });
  //
  //       _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
  //     } else {
  //       print("No camera available");
  //     }
  //   }).catchError((err) {
  //     print('Error: $err.code\nError Message: $err.message');
  //   });
  // }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller.dispose();
    }

    _controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (_controller.value.hasError) {
        print('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _takeFirstPhotoCamera(
      BuildContext context, CameraController controller) async {
    final camera1Cubit = context.bloc<Camera1Cubit>();
    await camera1Cubit.takeFirstPhoto(context, controller);

    _takeSecondPhotoCamera(context);
  }

  void _takeSecondPhotoCamera(BuildContext context) async {
    CameraController _controller2 =
        CameraController(cameras[1], ResolutionPreset.high);
    await _controller2.initialize();
    final camera1Cubit = context.bloc<Camera1Cubit>();
    await camera1Cubit.takeSecondPhoto(context, _controller2);
    _controller2.dispose();
    onSwitchCamera();
  }

  void onSwitchCamera() async {
    // selectedCameraIdx =
    //     selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    await _initCameraController(selectedCamera);
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
      backgroundColor: Color(0xFF1B4079),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        backgroundColor: Colors.black,
        onPressed: () {
          photoPreview(context, _controller);
        },
      ),
      body: Container(
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
              return buildInitialInput(context, null, null);
            } else if (state is Camera1Loading) {
              return buildLoading();
            } else if (state is Camera1TakePhotoPreview) {
              return cameraPreviewWidget(
                context,
                _controller,
              );
            } else if (state is Camera1FirstPhotoTaken) {
              return Text('First photo taken');
            } else if (state is Camera1PhotosPreview) {
              return buildInitialInput(
                  context, state.imageFile1, state.imageFile2);
            } else {
              // (state is WeatherError)
              return buildInitialInput(context, null, null);
            }
          },
        ),
      ),
    );
  }

  Widget cameraPreviewWidget(BuildContext context,
      CameraController controller) {
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
        FloatingActionButton(onPressed: () async {
          _takeFirstPhotoCamera(context, controller);
          print(selectedCameraIdx);
        })
      ],
    );
  }
}

Widget buildInitialInput(BuildContext context, File image1, File image2) {
  return _galleryWidget(context, image1, image2);
}

Widget _galleryWidget(BuildContext context, File image1, File image2) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlippableBox(
          back: buildCard(image1, 500, 300),
          front: buildCard(image1, 200, 200),
        ),
        FlippableBox(
          back: buildCard(image2, 500, 300),
          front: buildCard(image2, 200, 200),
        ),
      ],
    ),
  );
}

// void _takeFirstPhoto(BuildContext context, ImagePicker picker) {
//   final camera1Cubit = context.bloc<Camera1Cubit>();
//   camera1Cubit.takeFirstPhoto(picker);
// }

void photoPreview(BuildContext context, CameraController controller) {
  final camera1Cubit = context.bloc<Camera1Cubit>();
  camera1Cubit.photoPreview(controller);
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
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
