import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:masofaviy_talim_talaba/app/Services/api_client_service.dart';
import 'package:masofaviy_talim_talaba/app/Services/storage_service.dart';
import 'package:masofaviy_talim_talaba/app/modules/login/session_model.dart';
import '../../global/BaseResponse.dart';
import '../../global/app_urs.dart';
import '../loading/loading_controller.dart';
import '../notification/notification_controller.dart';

class AuthController extends ChangeNotifier {
  final ApiService apiService;
  final LoadingController loading;
  final NotificationController notify;

  AuthController( {required this.apiService, required this.loading, required this.notify});
  Future<BaseResponse<SessionModel>> login(String? email, String? password) async {
      notifyListeners();
      var response= await apiService.post<SessionModel>(
          endpoint: AppUrs.login,
          data: {
            "phone":email,
            "password":password},
          fromJsonT: SessionModel.fromJson);
      if(response.success??false){
        StorageService.accessToken=response.data?.accessToken;
        StorageService.refreshToken=response.data?.refreshToken;
        StorageService.role=response.data?.role;
      }
      return response;

  }
}