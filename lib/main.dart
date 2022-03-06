import 'package:flutter/material.dart';
import 'package:image_upload_app/ui/camera_view.dart';
import 'package:image_upload_app/ui/home_view.dart';
import 'package:image_upload_app/ui/locator/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeView(),
        '/camera': (_) => const CameraView(),
      },
    );
  }
}

