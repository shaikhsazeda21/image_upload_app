import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_upload_app/bloc/home/home_bloc.dart';
import 'package:image_upload_app/ui/camera_view.dart';

import 'locator/locator.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeBloc>()..add(const HomeInitialized()),
      child: BlocConsumer<HomeBloc, HomeState>(
          builder: (context, state) => Scaffold(
                appBar: AppBar(
                  title: const Text(
                    '',
                  ),
                  actions: [
                    state.file?.path != null
                        ? IconButton(
                            onPressed: () => BlocProvider.of<HomeBloc>(context)
                              ..add(HomeImageUploaded(
                                file: state.file!,
                              )),
                            icon: const Icon(Icons.cloud_upload_outlined),
                          )
                        : Container(),
                  ],
                ),
                body: SafeArea(
                  child: state.file?.path != null
                      ? Container(
                          width: double.infinity,
                          child: Image.file(
                            state.file!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          child: Image.asset('assets/images/camera.png'),
                        ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CameraView(),
                    ),
                  ).then((value) => BlocProvider.of<HomeBloc>(context)
                      .add(HomeInitialized(file: value))),
                  label: const Text('Open Camera'),
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
              ),
          listener: (context, state) {
            if (state is HomeImageUploadSuccess) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Success',
                  ),
                  content: Text(
                    '${state.success}',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            } else if (state is HomeImageUploadFailure){
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
          }),
    );
  }
}
