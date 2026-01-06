class AppRoutes {
  static const String login="/login";
  static const String home="/home";
  static const String grades="/grades";
  static const String students="/students";
  static const String profile="/profile";

  static const String subjects="/subjects";
  static String subjectDetailById(String? id)=>"$subjects/$id";

  static const String video="/video";
  static  String videoBySubjectAndVideoId(String? subjectId,String?videoId)=>"${subjectDetailById(subjectId)}$video/$videoId";

  static const String test="/test";
  static  String testBySubjectAndTestId(String? subjectId,String?testId)=>"${subjectDetailById(subjectId)}$test/$testId";

  static const String testAdd="/test_add";
  static  String testAddBySubjectAndTestId(String? subjectId,String?testId)=>"${subjectDetailById(subjectId)}$testAdd/$testId";

  static const String assignmentSubmission="/assignment_submission";
  static  String submissionBySubjectAndAssignmentId(String? subjectId,String?id)=>"${subjectDetailById(subjectId)}$assignmentSubmission/$id";

  static const String assignment="/assignment";
  static  String assignmentBySubjectAndAssignmentId(String? subjectId,String?id)=>"${subjectDetailById(subjectId)}$assignment/$id";

  static const String testResult="/test_result";
  static  String testResultBySubjectAndAssignmentId(String? subjectId,String?id)=>"${subjectDetailById(subjectId)}$testResult/$id";

}