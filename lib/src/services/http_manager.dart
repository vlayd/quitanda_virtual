import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String post = "POST";
  static const String get = "GET";
  static const String put = "PUT";
  static const String patch = "PATCH";
  static const String delete = "DELETE";
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    String method = HttpMethods.post,
    Map? headers,
    Map? body,
  }) async {
    //Headers da requisição
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        "content-type": "application/json",
        "accept": "application/json",
        "X-Parse-Application-Id": "Bd46ziMNN2mnWMTaptAhasrYGvmhmuvE4tWBZYeg",
        "X-Parse-REST-API-Key": "i3Up64CFHyMoKmMXR5DdWMHlygQG5ghD95m7CxgX",
      });
    Dio dio = Dio();
    try {
      Response response = await dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: method,
        ),
        data: body,
      );
      //Retorno do resultado do backend
      return response.data;
    } on DioError catch (e) {
      //Retorno do dio request
      return e.response?.data ?? {};
    } catch (e) {
      //Retorno de map vazio para erro genérico
      return {};
    }
  }
}
