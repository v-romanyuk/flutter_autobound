import 'package:http/http.dart' as http_service;

class _HttpService {
  _parseUri(String url) {
    return Uri.parse(url.contains('http')
        ? url
        : 'https://dev.autobound.ai/api/$url');
  }

  Future<http_service.Response> get(String url, {Map<String, String>? headers}) {
    return http_service.get(_parseUri(url), headers: headers);
  }

  Future<http_service.Response> post<T>(String url, {Object? body, Map<String, String>? headers}) {
    return http_service.post(_parseUri(url), body: body, headers: headers);
  }

  Future<http_service.Response> put(String url, {Object? body, Map<String, String>? headers}) {
    return http_service.put(_parseUri(url), body: body, headers: headers);
  }

  Future<http_service.Response> patch(String url, {Object? body, Map<String, String>? headers}) {
    return http_service.patch(_parseUri(url), body: body, headers: headers);
  }

  Future<http_service.Response> delete(String url, {Object? body, Map<String, String>? headers}) {
    return http_service.patch(_parseUri(url), body: body, headers: headers);
  }
}

final http = _HttpService();
