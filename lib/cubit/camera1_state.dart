part of 'camera1_cubit.dart';

abstract class Camera1State extends Equatable {
  const Camera1State();
}

class Camera1Initial extends Camera1State {
  @override
  List<Object> get props => throw UnimplementedError();
}

class Camera1TakePhotoPreview extends Camera1State {
  final CameraController controller;

  const Camera1TakePhotoPreview(this.controller);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Camera1FirstPhotoTaken extends Camera1State {
  const Camera1FirstPhotoTaken();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Camera1PhotosPreview extends Camera1State {
  final File imageFile1;
  final File imageFile2;

  const Camera1PhotosPreview({this.imageFile1, this.imageFile2});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Camera1Loading extends Camera1State {
  const Camera1Loading();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Camera1SecondPhotoPreview extends Camera1State {
  const Camera1SecondPhotoPreview();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Camera1Error extends Camera1State {
  final String message;

  const Camera1Error(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
