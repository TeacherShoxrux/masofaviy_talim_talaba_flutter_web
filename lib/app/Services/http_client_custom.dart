import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masofaviy_talim_talaba/app/Services/storage_service.dart';


import 'package:flutter/foundation.dart'; // kDebugMode uchun

class CustomHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // 1. Interceptor: headerga token qo‘shish
    final token = StorageService.accessToken;
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    // 2. Interceptor: so‘rovni log qilish (agar debug rejim bo‘lsa)
    if (kDebugMode) {
      print(' [${request.method}] ${request.url}');
      print('Headers: ${request.headers}');
      if (request is http.Request && request.body.isNotEmpty) {
        print('Body: ${request.body}');
      }
    }

    // 3. Javobni ushlash
    final response = await _inner.send(request);

    // 4. 401 => logout + redirect
    // if (response.statusCode == 401) {
    //   await AuthService().logout();
    //
    //   // Login sahifaga redirect
    //   navigatorKey.currentState?.pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (_) =>  LoginPage()),
    //         (route) => false,
    //   );
    // }

    // 5. Interceptor: javob logi
    // if (kDebugMode) {
    //   final cloned = await http.Response.fromStream(response);
    //   print('⬅️ [${cloned.statusCode}] ${request.url}');
    //   print('Response body: ${cloned.body}');
    //   return http.StreamedResponse(
    //     Stream.value(utf8.encode(cloned.body)),
    //     cloned.statusCode,
    //     headers: cloned.headers,
    //     reasonPhrase: cloned.reasonPhrase,
    //     request: response.request,
    //   );


    return response;
  }
}