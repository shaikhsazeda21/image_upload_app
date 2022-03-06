part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final File? file;

  const HomeState({this.file});

  @override
  List<Object?> get props => [file];
}

class HomeInitial extends HomeState {
  final File? file;

  const HomeInitial({this.file});
}

class HomeImageUploadSuccess extends HomeState {
  final String success;

  const HomeImageUploadSuccess({this.success = 'Image Uploaded Success'});

  @override
  List<Object?> get props => [success];
}

class HomeImageUploadFailure extends HomeState {
  final String error;

  const HomeImageUploadFailure({this.error = 'Image Upload Failed'});

  @override
  List<Object?> get props => [error];
}