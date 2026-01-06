import 'package:dio/dio.dart';
import 'package:masofaviy_talim_talaba/app/services/storage_service.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:html'as html;
import 'dart:typed_data';

import '../global/base_response.dart';
import '../global/app_urs.dart';
import 'http_client_custom.dart';


class ApiService {
  static final ApiService _instance = ApiService._();
  factory ApiService() => _instance;
  ApiService._();


  final String baseUrl = AppUrs.baseUrl;
  final http.Client httpClient = CustomHttpClient();

  Future<String> uploadImage(String endpoint, PlatformFile file) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer ${StorageService.accessToken}'
      ..files.add(http.MultipartFile.fromBytes(
          'image', await file.xFile.readAsBytes(),
          filename: file.name,
          contentType: MediaType('image','${file.identifier}')));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      throw Exception('Image upload error: ${response.statusCode} → ${response.body}');
    }
  }

  Future<void> downloadFileFromBackend({required String url, String? fallbackFileName}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$url'),
        headers: {
          'Authorization': 'Bearer  ${StorageService.accessToken}'
        },
      );

      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;

        // Fayl nomini Content-Disposition headerdan olish
        final contentDisposition = response.headers['content-disposition'];
        String fileName = fallbackFileName ?? 'downloaded_file.xlsx';

        if (contentDisposition != null && contentDisposition.contains('filename=')) {
          final regex = RegExp(r'filename="?(.+?)"?($|;)', caseSensitive: false);
          final match = regex.firstMatch(contentDisposition);
          if (match != null && match.groupCount >= 1) {
            fileName = match.group(1)!;
          }
        }

        // MIME type - serverdan kelayotganiga ishonamiz
        final mimeType = response.headers['content-type'] ?? 'application/octet-stream';

        // Faylni brauzerda yuklab berish
        final blob = html.Blob([bytes], mimeType);
        final url = html.Url.createObjectUrlFromBlob(blob);

        final anchor = html.AnchorElement(href: url)
          ..download = fileName
          ..click();

        html.Url.revokeObjectUrl(url);
      } else {
        print('Xatolik: ${response.statusCode}');
      }
    } catch (e) {
      print('Faylni yuklab olishda xatolik: $e');
    }
  }

  Future<BaseResponse<T>> get<T>(String endpoint, T Function(Map<String, dynamic> json) fromJsonT) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/$endpoint'));
    return BaseResponse<T>.fromJson(_handleResponse(response), fromJsonT);
  }
  Future<BaseResponseList<T>> getList<T>(String endpoint, T Function(Map<String, dynamic> json) fromJsonT) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/$endpoint'));
    return BaseResponseList<T>.fromJson(_handleResponse(response), fromJsonT);
  }

  Future<BaseResponse<T>> post<T>({required String endpoint, required Map<String, dynamic> data,required T Function(Map<String, dynamic>) fromJsonT}) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return BaseResponse.fromJson(_handleResponse(response), fromJsonT);
  }

  Future<BaseResponse<T>> put<T>({required String endpoint, required Map<String, dynamic> data,required T Function(Map<String, dynamic>) fromJsonT}) async {
    final response = await httpClient.put(Uri.parse('$baseUrl/$endpoint'),headers: {'Content-Type': 'application/json'},body: jsonEncode(data));
    return BaseResponse.fromJson(_handleResponse(response), fromJsonT);
  }

  Future<BaseResponse<T>> delete<T>(String endpoint,T Function(Map<String, dynamic>) fromJsonT,) async {
    final response = await httpClient.delete(Uri.parse('$baseUrl/$endpoint'));
    return BaseResponse.fromJson(_handleResponse(response), fromJsonT);
  }
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300 ||response.statusCode== 404||response.statusCode== 400) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error: ${response.statusCode} → ${response.body}');
    }
  }
}