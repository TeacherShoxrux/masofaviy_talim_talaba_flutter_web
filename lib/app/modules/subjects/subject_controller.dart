import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/home/model/statistics_model.dart';
import 'package:masofaviy_talim_talaba/app/modules/students/model/student_model.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/models/subject_model.dart';

import '../../Services/api_client_service.dart';
import '../../global/app_urs.dart';
import '../loading/loading_controller.dart';
import '../notification/notification_controller.dart';

class SubjectController extends ChangeNotifier {
  final ApiService apiService;
  final LoadingController loading;
  final NotificationController notify;
  List<SubjectModel> subjects=List.empty();
  SubjectController( {required this.apiService, required this.loading, required this.notify});

  Future<void> getSubjectList() async {
    try {
      loading.show();
      final response = await apiService.getList<SubjectModel>(AppUrs.subjectsStudent,SubjectModel.fromJson);
      if (response.success) {
        subjects = response.data;
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