import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart';
import 'package:image_upload_app/repository/repository.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';
part 'home_event.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository _repository;

  HomeBloc(this._repository) : super(HomeInitial()) {
    if (!isClosed) {
      handleEvents();
    }
  }

  void handleEvents() {
    on<HomeInitialized>(_mapHomeImageInitializedToState);
    on<HomeImageUploaded>(_mapHomeImageUploadedToState);
  }

  Future<void> _mapHomeImageInitializedToState(
    HomeInitialized event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeInitial(file: event.file));
  }

  Future<void> _mapHomeImageUploadedToState(
    HomeImageUploaded event,
    Emitter<HomeState> emit,
  ) async {
    String _base64Image = await _getCompressedImage(file: event.file);
    try {
      await _repository.uploadImage(base64Image: _base64Image);
      emit(const HomeImageUploadSuccess());
    } catch (e) {
      emit(HomeImageUploadFailure(error: e.toString()));
    }
  }

  Future<String> _getCompressedImage({required File file}) async {
    var _fileLength = await file.length();
    if ((_fileLength / 1048576) > 4.0) {
      Image _image = decodeImage(file.readAsBytesSync()) as Image;
      var _compressedImage = File(file.path)
        ..writeAsBytesSync(encodeJpg(_image, quality: 85));
      var _compressedFileLength = await _compressedImage.length();
      if ((_compressedFileLength / 1048576) > 4.0) {
        return _getCompressedImage(file: _compressedImage);
      } else {
        return _convertImageToBase64(_compressedImage);
      }
    } else {
      return _convertImageToBase64(file);
    }
  }

  String _convertImageToBase64(File image) {
    List<int> _imageBytes = image.readAsBytesSync();
    String _imageBase64 = base64Encode(_imageBytes);
    return _imageBase64;
  }
}
