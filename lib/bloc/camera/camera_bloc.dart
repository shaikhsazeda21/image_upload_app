import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_upload_app/utils/camera_utils.dart';
import 'package:injectable/injectable.dart';

part 'camera_state.dart';
part 'camera_event.dart';

@injectable
class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraUtils _cameraUtils;

  late CameraController _cameraController;

  CameraBloc(
    this._cameraUtils,
  ) : super(
          CameraInitial(),
        ) {
    if (!isClosed) {
      handleEvents();
    }
  }

  CameraController getController() => _cameraController;

  bool isInitialized() => _cameraController.value.isInitialized;

  void handleEvents() {
    on<CameraInitialized>(_mapCameraInitializedToState);
    on<CameraCaptured>(_mapCameraCapturedToState);
    on<CameraStopped>(_mapCameraStoppedToState);
  }

  Future<void> _mapCameraInitializedToState(
    CameraInitialized event,
    Emitter<CameraState> emit,
  ) async {
    try {
      _cameraController = await _cameraUtils.getCameraController();
      await _cameraController.initialize();
      emit(CameraReady());
    } on CameraException catch (e) {
      _cameraController.dispose();
      emit(CameraFailure(error: e.description.toString()));
    } catch (e) {
      _cameraController.dispose();
      emit(CameraFailure(error: e.toString()));
    }
  }

  Future<void> _mapCameraCapturedToState(
      CameraCaptured event,
      Emitter<CameraState> emit,
      ) async {
    if (state is CameraReady) {
      emit(CameraCaptureInProgress());
      try {
        XFile _file = await _cameraController.takePicture();
        emit(CameraSuccess(File(_file.path)));
      } on CameraException catch (e) {
        emit(CameraFailure(error: e.description.toString()));
      } catch (e) {
        emit(CameraFailure(error: e.toString()));
      }
    }
  }

  Future<void> _mapCameraStoppedToState(
      CameraStopped event,
      Emitter<CameraState> emit,
      ) async {
    _cameraController.dispose();
    emit(CameraInitial());
  }

  @override
  Future<void> close() {
    _cameraController.dispose();
    return super.close();
  }
}
