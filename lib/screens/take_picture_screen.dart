import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera1_app/cubit/camera1_cubit.dart';
import 'package:camera1_app/screens/galery_screen.dart';
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
  final Color bgColor = Color(0xFF2A0F2E);

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
  //           onPressed: reInitializeCameraOneController,
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

  // function for camera controller initialization
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

//cuibt communication function to take the frist photo

  void _takeFirstPhotoCamera(
      BuildContext context, CameraController controller) async {
    final camera1Cubit = context.bloc<Camera1Cubit>();
    await camera1Cubit.takeFirstPhoto(context, controller);

    _takeSecondPhotoCamera(context);
  }

//cuibt communication function to take the second photo

  void _takeSecondPhotoCamera(BuildContext context) async {
    CameraController _controller2 =
        CameraController(cameras[1], ResolutionPreset.high);
    await _controller2.initialize();
    final camera1Cubit = context.bloc<Camera1Cubit>();
    await camera1Cubit.takeSecondPhoto(context, _controller2);
    _controller2.dispose();
    reInitializeCameraOneController();
  }

// function for re-initialization of the front camera contrller after taking a photo
  void reInitializeCameraOneController() async {
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

// take picture screeen tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // decoration: BoxDecoration(
          //     color: Color(0xFF1C0A1F),
          //     border: Border.all(
          //       color: Colors.black,
          //     ),
          //     borderRadius: BorderRadius.all(Radius.circular(20))),
          // height: 800,
          // width: 500,
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
              //first page - Galery
              if (state is Camera1Initial) {
                return buildInitialInput(context, _controller);
                //loading call
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
                return buildPreviewScreen(
                    context, state.imageFile1, state.imageFile2);
              } else {
                // (state is WeatherError)
                return buildInitialInput(context, _controller);
              }
            },
          ),
        ),
      ),
    );
  }

// camera preview widget
  Widget cameraPreviewWidget(
      BuildContext context, CameraController controller) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
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

    return Stack(
      children: [
        Transform.scale(
          scale: controller.value.aspectRatio / deviceRatio,
          child: Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 33),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      _takeFirstPhotoCamera(context, controller);
                      print(selectedCameraIdx);
                    },
                    child: Icon(Icons.camera),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 33,
                    ),
                  ),
                  Icon(
                    Icons.flash_on_rounded,
                    size: 33,
                  ),
                  Icon(
                    Icons.timer,
                    size: 33,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildInitialInput(BuildContext context, CameraController controller) {
    return cameraPreviewWidget(context, controller);
  }
}

Widget buildPreviewScreen(BuildContext context, File image1, File image2) {
  return _previewWidget(context, image1, image2);
}

Widget _previewWidget(BuildContext context, File image1, File image2) {
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
