class AppUrs {
  /// Routes

  static const baseUrl="http://localhost:5000";
  static const checkFace="api/Auth/CheckFace";
  static const login="api/Auth/Login";
  static const dashboard="api/Student/Dashboard";
  static const teacherProfile="api/Teacher";
  static const subjectsStudent="api/Student/GetAllSubjects";


  /// Urls
  static String subjectsAll([int page=1,int pageSize=50])=>"api/Subject/All?page=$page&pageSize=$pageSize";
  static String students([int page=1,int pageSize=50])=>"api/Student/GetAll?page=$page&pageSize=$pageSize";
  static String subjectDetails(String id)=>"api/Subject?id=$id";
  static String video(String? id)=>"api/Video/$id";
  static String videoAllVideoSubjectId(String? id)=>"api/Video/GetAllVideoList/$id";
  static String videoCreate="api/Video/";




}