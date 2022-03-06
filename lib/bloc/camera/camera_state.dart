part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {}

class CameraCaptureInProgress extends CameraState {}

class CameraFailure extends CameraState {
  final String error;

  const CameraFailure({this.error = 'Camera failure'});

  @override
  List<Object> get props => [error];
}

class CameraSuccess extends CameraState {
  final File file;

  const CameraSuccess(this.file);

  @override
  List<Object> get props => [file];
}