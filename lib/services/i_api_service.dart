import 'package:dio/dio.dart';
import 'package:image_upload_app/model/image_model.dart';

abstract class IApiService{
  Future<Response> uploadImage(ImageModel base64Image);
}