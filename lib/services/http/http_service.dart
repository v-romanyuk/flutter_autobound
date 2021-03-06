import 'package:Autobound/models/general_models.dart';
import 'package:Autobound/providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart' as get_instance;

class HttpInterceptor extends Interceptor  {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['auth'] = get_instance.Get.context!.read<AuthProvider>().token;
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      showCupertinoDialog(
        context: get_instance.Get.context!,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Session expired.'),
          content: const Text('Please login again.'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('Go to login screen again'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
    return super.onError(err, handler);
  }
}

class _HttpService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://dev.autobound.ai/api'
  ))..interceptors.add(HttpInterceptor());

  Future<Response> get(String url) {
    return _dio.get(url);
  }

  Future<Response<T>> post<T>(String url, {data, DynamicMap? queryParameters, Options? options}) async {
    return _dio.post(url, data: data, queryParameters: queryParameters, options: options);
  }
}

final httpService = _HttpService();
