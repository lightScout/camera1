import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

part 'camera1_state.dart';

class Camera1Cubit extends Cubit<Camera1State> {
  Camera1Cubit() : super(Camera1Initial());
  File imageFile1;
  File imageFile2;

  Future<void> takeFirstPhoto(
      BuildContext context, CameraController controller) async {
    try {
      emit(Camera1Loading());
      imageFile1 = await _onCapturePressed(context, controller);
      emit(Camera1FirstPhotoTaken());
    } catch (e) {
      emit(Camera1Error(e));
    }
  }

  Future<void> takeSecondPhoto(
      BuildContext context, CameraController controller) async {
    try {
      emit(Camera1Loading());
      imageFile2 = await _onCapturePressed(context, controller);
      emit(
          Camera1PhotosPreview(imageFile1: imageFile1, imageFile2: imageFile2));
    } catch (e) {
      emit(Camera1Error(e));
    }
  }

  Future<void> photoPreview(CameraController controller) async {
    try {
      emit(Camera1TakePhotoPreview(controller));
    } catch (e) {
      emit(Camera1Error(e));
    }
  }
}

Future<File> getImage(picker) async {
  File image;
  final pickedFile = await picker.getImage(source: ImageSource.camera);

  if (pickedFile != null) {
    image = File(pickedFile.path);
  } else {
    print('No image selected.');
  }
  return image;
}

Future<File> _onCapturePressed(context, controller) async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = '${extDir.path}/Pictures/flutter_test';
  await Directory(dirPath).create(recursive: true);
  final String filePath = '$dirPath/${DateTime.now()}.jpg';
  File imageFile;
  try {
    await controller.takePicture(filePath);
    imageFile = File(filePath);
  } catch (e) {
    print(e);
  }

  return imageFile;
}
