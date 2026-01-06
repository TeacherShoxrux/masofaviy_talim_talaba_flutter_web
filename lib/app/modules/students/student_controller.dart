import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/home/model/statistics_model.dart';
import 'package:masofaviy_talim_talaba/app/modules/students/model/student_model.dart';

import '../../Services/api_client_service.dart';
import '../../global/app_urs.dart';
import '../loading/loading_controller.dart';
import '../notification/notification_controller.dart';

class StudentController extends ChangeNotifier {
  final ApiService apiService;
  final LoadingController loading;
  final NotificationController notify;
  List<StudentModel> students=List.empty();
  StudentController( {required this.apiService, required this.loading, required this.notify});

  Future<void> getStudentsList() async {
    try {
      loading.show();
      final response = await apiService.getList<StudentModel>(AppUrs.students(),StudentModel.fromJson);
      print(response.data);
      if (response.success) {
        students = response.data;
        notifyListeners(); //
      } else {
        notify.show(
          "Ma'lumotlarni olishda xatolik: ${response.errorMessage}",
          NotifyType.warning,
        );
      }
    } catch (e) {
      notify.show(
        "Xatolik yuz berdi: $e",
        NotifyType.error,
      );
    } finally {
      loading.hide();
    }}
}