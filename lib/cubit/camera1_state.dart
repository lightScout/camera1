part of 'camera1_cubit.dart';

abstract class Camera1State extends Equatable {
  const Camera1State();
}

class Camera1Initial extends Camera1State {
  @override
  List<Object> get props => throw UnimplementedError();
}

class Camera1FirstPhoto extends Camera1State {
  const Camera1FirstPhoto();

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

class Camera1SecondPhoto extends Camera1State {
  const Camera1SecondPhoto();

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
