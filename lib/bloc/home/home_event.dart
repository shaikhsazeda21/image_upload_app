part of 'home_bloc.dart';


abstract class HomeEvent extends Equatable {
  final File? file;

  const HomeEvent({this.file});

  @override
  List<Object?> get props => [file];
}

class HomeInitialized extends HomeEvent {
  final File? file;

  const HomeInitialized({this.file});
}

class HomeImageUploaded extends HomeEvent {
  final File file;

  const HomeImageUploaded({required this.file});
}