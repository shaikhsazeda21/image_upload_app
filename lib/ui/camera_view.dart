import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_upload_app/bloc/camera/camera_bloc.dart';
import 'package:image_upload_app/ui/locator/locator.dart';

class CameraView extends StatelessWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<CameraBloc>()..add(CameraInitialized()),
      child: BlocConsumer<CameraBloc, CameraState>(
        builder: (context, state) => Scaffold(
          body: state is CameraReady
              ? SafeArea(
                  child: CameraPreview(
                    BlocProvider.of<CameraBloc>(context).getController(),
                  ),
                )
              : state is CameraFailure
                  ? Container()
                  : Container(),
          floatingActionButton: state is CameraReady
              ? FloatingActionButton(
                  onPressed: () => BlocProvider.of<CameraBloc>(context).add(
                    CameraCaptured(),
                  ),
                )
              : Container(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
        listener: (context, state) {
          if (state is CameraSuccess) {
            Navigator.of(context).pop(state.file);
          } else if (state is CameraFailure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(
                  'Failed',
                ),
                content: Text(
                  '${state.error}',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Ok'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
