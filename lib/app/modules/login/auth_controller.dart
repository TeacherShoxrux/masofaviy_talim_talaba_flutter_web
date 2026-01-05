import 'package:flutter/cupertino.dart';
import 'package:masofaviy_talim_talaba/app/modules/login/auth_repo.dart';
import 'package:masofaviy_talim_talaba/app/modules/login/session_model.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository repository;
  AuthController( {required this.repository});
  bool loading=false;
  Future<SessionModel> login(String email, String password) async {
      notifyListeners();
      return await repository.login(email, password);
  }
}