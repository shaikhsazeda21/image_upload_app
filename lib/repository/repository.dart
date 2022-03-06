import 'package:dio/dio.dart';
import 'package:image_upload_app/model/image_model.dart';
import 'package:image_upload_app/services/i_api_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class Repository {
  final IApiService _apiService;

  Repository(this._apiService);

  Future<Response> uploadImage({required String base64Image}) async => await _apiService.uploadImage(ImageModel(base64: base64Image));
}
