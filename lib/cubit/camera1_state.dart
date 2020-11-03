part of 'camera1_cubit.dart';

abstract class Camera1State extends Equatable {
  const Camera1State();
}

class Camera1Initial extends Camera1State {
  @override
  List<Object> get props => throw UnimplementedError();
}

class Camera1FirstPhotoPreview extends Camera1State {
  final photoPath;

  const Camera1FirstPhotoPreview(this.photoPath);

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
