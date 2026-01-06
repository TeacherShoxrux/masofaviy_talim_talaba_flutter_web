class AppUrs {
  static const baseUrl="http://localhost:5000";
  static const checkFace="api/Auth/CheckFace";
  static const login="api/Auth/Login";
  static const dashboard="api/Student/Dashboard";
  static const subjectsStudent="api/Student/GetAllSubjects";
  static String students([int page=1,int pageSize=50])=>"api/Student/GetAll?page=$page&pageSize=$pageSize";



}