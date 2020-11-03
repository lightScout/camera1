import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'camera1_state.dart';

class Camera1Cubit extends Cubit<Camera1State> {
  Camera1Cubit() : super(Camera1Initial());
}
