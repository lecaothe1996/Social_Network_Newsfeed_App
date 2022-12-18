import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:social_app/utils/preference_util.dart';
import 'package:social_app/welcome/auth/gmail_login.dart';

class DioUtil {
  late Dio _dio;

  String get _accessToken {
    return PreferenceUtils.getString('access_token');
  }

  // Singleton
  static final DioUtil _instance = DioUtil._internal();

  factory DioUtil() {
    return _instance;
  }

  DioUtil._internal() {
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
          options.headers['Authorization'] = 'Bearer $_accessToken';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          // print('⚡️ _accessToken $_accessToken');
          return handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
          print('⚡️ _accessToken $_accessToken');

          if (e.response?.statusCode == 401) {
            await AuthGmail().refreshToken();
          }

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