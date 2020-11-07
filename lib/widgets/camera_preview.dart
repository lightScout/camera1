import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Widget cameraPreviewWidget(BuildContext context, CameraController controller,
    Function takeFristPhotoCamera) {
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
                  onPressed: () {
                    takeFristPhotoCamera();
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
