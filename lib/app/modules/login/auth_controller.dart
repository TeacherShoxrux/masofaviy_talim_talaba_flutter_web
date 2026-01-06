import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/Services/api_client_service.dart';
import 'package:masofaviy_talim_talaba/app/Services/storage_service.dart';
import 'package:masofaviy_talim_talaba/app/app_routes.dart';
import 'package:masofaviy_talim_talaba/app/modules/login/session_model.dart';
import 'package:masofaviy_talim_talaba/main.dart';
import '../../global/app_urs.dart';
import '../loading/loading_controller.dart';
import '../notification/notification_controller.dart';

class AuthController extends ChangeNotifier {
  final ApiService apiService;
  final LoadingController loading;
  final NotificationController notify;

  AuthController( {required this.apiService, required this.loading, required this.notify});
  Future<void> login(String? email, String? password) async {
      notifyListeners();
      try{
        loading.show();
        var response= await apiService.post<SessionModel>(
            endpoint: AppUrs.login,
            data: {
              "phone":email,
              "password":password},
            fromJsonT: SessionModel.fromJson);
        if(response.success){
          notify.show("Tizimga kidinggiz", NotifyType.success);
          StorageService.accessToken=response.data?.accessToken;
          StorageService.refreshToken=response.data?.refreshToken;
          StorageService.role=response.data?.role;
          Future.microtask(() {
            navigatorKey.currentContext?.go(AppRoutes.home);
          });
        }else{
          notify.show("Tizimga kirishda xatolik: ${response.errorMessage}", NotifyType.warning);
        }
      }catch(e){
        notify.show("Xatolik yuz berdi: $e", NotifyType.error);
      }finally{
        loading.hide();
      }

  }
}