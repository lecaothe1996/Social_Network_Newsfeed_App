import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:social_app/utils/preference_utils.dart';

class MyClient {
  late Dio _dio;

  String get _accessToken {
    return PreferenceUtils.getString('access_token');
  }

  // Singleton
  static final MyClient _instance = MyClient._internal();

  factory MyClient() {
    return _instance;
  }

  MyClient._internal() {
    final baseOptions = BaseOptions(baseUrl: 'https://api.dofhunt.200lab.io/v1');
    _dio = Dio(baseOptions);
    setupInterceptors();
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseAndDecode;
  }

  // Thiết lập trước khi gửi lên server
  void setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          print('⚡️ MyClient [${options.method}] - ${options.uri}');
          print('⚡️ _accessToken: ${_accessToken}');
          // if (_accessToken.isEmpty) {
          //   _dio.lock();
          //   return SharedPreferences.getInstance().then((sharedPreferences) {
          //     TokenManager().load();
          //     options.headers['Authorization'] = 'Bearer $_accessToken';
          //     _dio.unlock();
          //     return handler.next(options);
          //   });
          // }
          options.headers['Authorization'] = 'Bearer $_accessToken';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
          print('⚡️ _accessToken ${_accessToken}');
          // TODO: refresh token && handle error
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    final res = _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return res;
  }

  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    final res = _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return res;
  }
}

dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}