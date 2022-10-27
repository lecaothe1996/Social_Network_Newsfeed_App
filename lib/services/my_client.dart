// import 'package:http/http.dart' as http;
//
// class MyClient {
//   final String _accessToken = 'bda16dc21c6aae9f8b59ff70fc13d08d67f86bba95b3f6b44c2cda0a70122524';
//   final String _baseUrl = 'gorest.co.in';
//
//   Uri _buildUri({String id = '', Map<String, dynamic>? queryParameters}) {
//     return Uri.https(
//       _baseUrl,
//       'public/v2/users/$id',
//       queryParameters,
//     );
//   }
//
//   Map<String, String> get _headers {
//     return {"Authorization": "Bearer $_accessToken"};
//   }
//
//   Map<String, dynamic> _body(User user) {
//     return {
//       "name": user.name,
//       "email": user.email,
//       "gender": user.gender,
//       "status": user.status,
//     };
//   }
//
//   Future<http.Response> get({Map<String, dynamic>? queryParameters}) {
//     print('_buildUri==${_buildUri()}');
//     return http.get(
//       _buildUri(queryParameters: queryParameters),
//       headers: _headers,
//     );
//   }
//
//   Future<http.Response> post(User user) {
//     return http.post(
//       _buildUri(),
//       headers: _headers,
//       body: _body(user),
//     );
//   }
//
//   Future<http.Response> put(User user) {
//     return http.put(
//       _buildUri(id: user.id.toString()),
//       headers: _headers,
//       body: _body(user),
//     );
//   }
//
//   Future<http.Response> delete(User user) {
//     return http.delete(
//       _buildUri(id: user.id.toString()),
//       headers: _headers,
//     );
//   }
// }