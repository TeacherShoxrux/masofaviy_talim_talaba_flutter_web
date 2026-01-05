import 'package:masofaviy_talim_talaba/app/modules/login/session_model.dart';

import '../../Services/storage_service.dart';
import '../../global/theme/BaseResponse.dart';
import 'auth_api.dart';

class AuthRepository {
  final AuthApi api;

  AuthRepository(this.api);

  Future<SessionModel> login(String email, String password) async {
      final json = await api.login(email, password);

      final base = BaseResponse<SessionModel>.fromJson(
        json,
            (data) => SessionModel.fromJson(data),
      );

      if (!base.success) {
        throw base.errorMessage ?? "Noma’lum xatolik";
      }

      final user = base.data!;
      await StorageService.setAccessToken(user.accessToken);
      // await StorageService.setRefreshToken(user.refreshToken);
      // await StorageService.setRole(user.role);

      return user;

  }
}