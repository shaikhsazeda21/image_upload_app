import 'package:dio/dio.dart';
import 'package:image_upload_app/model/image_model.dart';
import 'package:image_upload_app/services/i_api_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IApiService)
class ApiService extends IApiService {
  final _dio = Dio()
    ..options.baseUrl = 'https://jsonplaceholder.typicode.com/'
    ..options.contentType = 'application/json'
    ..options.connectTimeout = 25000
    ..options.receiveTimeout = 25000
    ..options.headers = {
      'token': 'xxxxyyyyzzzz',
    };

  @override
  Future<Response> uploadImage(ImageModel base64Image) async {
    try {
      Response response = await _dio.post(
        '/posts',
        data: base64Image.toJson(),
      );
      return response;
    } on DioError catch (error) {
      return error.response as Response;
    } catch (error) {
      return error as Response;
    }
  }
}
