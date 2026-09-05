import 'package:dio/dio.dart';

class ApiClient {
  ApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<T?> get<T>(String path) async {
    final response = await _dio.get<T>(path);
    return response.data;
  }
}
