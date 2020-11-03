import 'package:bloc/bloc.dart';
import 'package:camera1_app/screens/take_picture_screen.dart';
import 'package:equatable/equatable.dart';

part 'camera1_state.dart';

class Camera1Cubit extends Cubit<Camera1State> {
  Camera1Cubit() : super(Camera1Initial());

  Future<void> takeFirstPhoto() async {
    try {
      emit(Camera1Loading());
      final firstPhotoPath = await getFirstPhoto();
      print('getFirstPhoto $firstPhotoPath');
      emit(Camera1FirstPhotoPreview(firstPhotoPath));
    } catch (e) {
      emit(Camera1Error(e));
    }
  }
}

Future<String> getFirstPhoto() async {
  String path;
  try {
    path = await TakePictureScreenState().onCapture();
  } catch (e) {
    print(e);
  }
  return path;
}
