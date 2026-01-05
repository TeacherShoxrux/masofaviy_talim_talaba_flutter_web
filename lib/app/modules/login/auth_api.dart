import 'package:masofaviy_talim_talaba/app/services/api_client_service.dart';

class AuthApi {
  Future<Map<String, dynamic>> login(
      String email, String password) async {
    final res = await ApiClientService.dio.post(
      '/api/Auth/Login',data: {'phone': email, 'password': password});
    return res.data;
  }
}