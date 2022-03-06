import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class CameraUtils {
  Future<CameraController> getCameraController({
    ResolutionPreset resolutionPreset = ResolutionPreset.high,
    CameraLensDirection cameraLensDirection = CameraLensDirection.back,
  }) async {
    final _availableCamera = await availableCameras();

    final _camera = _availableCamera.firstWhere((camera) => camera.lensDirection == cameraLensDirection);

    return CameraController(_camera, resolutionPreset, enableAudio: false);
  }

  Future<String> getPath() async => join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
}

void walk ({int km = 10}) {

}
