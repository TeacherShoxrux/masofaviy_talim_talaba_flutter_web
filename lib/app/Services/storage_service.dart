import 'dart:html' as html;

class StorageService {
  static final html.Storage _prefs=html.window.localStorage;
  // static late SharedPreferences _prefs;

  static String? _accessToken;
  static String? _refreshToken;
  static String? _role;

  // INIT (majburiy)
  static Future<void> init() async {
    // _prefs = await SharedPreferences.getInstance();
  }

  // ================= ACCESS TOKEN =================
  static String? get accessToken =>
      _accessToken ??=_prefs["accessToken"];

  static set accessToken(String? value)  {
    _accessToken = value;
    _prefs['accessToken']=value??"";

  }

  // ================= REFRESH TOKEN =================
  static String? get refreshToken =>
      _refreshToken ??=_prefs["refreshToken"];

  static set refreshToken(String? value) {
    _refreshToken = value;
    _prefs['refreshToken']=value??"";
  }
  // ================= ROLE =================
  static String? get role =>
      _role ??=_prefs["role"];

  static  set role(String? value) {
    _role = value;
    _prefs['role']=value??"";
  }
  // ================= CLEAR =================
  static void clear(){
    _accessToken = null;
    _refreshToken = null;
    _role = null;
   _prefs.clear();
  }
}
