import 'package:dio/dio.dart';
import 'package:masofaviy_talim_talaba/app/global/theme/app_urs.dart';
import 'package:masofaviy_talim_talaba/app/services/storage_service.dart';

class ApiClientService {
  static final dio = Dio(
    BaseOptions(
      baseUrl: AppUrs.baseUrl,
      headers: {
        'Content-Type': 'application/json'},
    ))..interceptors.add(
  InterceptorsWrapper(
  onRequest: (options, handler) {
  final token = StorageService.accessToken;
  if (token != null && token.isNotEmpty) {
  options.headers['Authorization'] = 'Bearer $token';
  }
  handler.next(options);
  },
  )
  );
}