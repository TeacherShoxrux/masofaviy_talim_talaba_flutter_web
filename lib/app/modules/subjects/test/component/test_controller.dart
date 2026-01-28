import 'package:flutter/cupertino.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/test_add/components/question_create_model.dart';

import '../../../../Services/api_client_service.dart';
import '../../../../global/app_urs.dart';
import '../../../loading/loading_controller.dart';
import '../../../notification/notification_controller.dart';
import '../../test_add/test_with_questions_model.dart';

class TestController  extends ChangeNotifier {
  final ApiService apiService;
  final LoadingController loading;
  final NotificationController notify;
  TestWithQuestions? testWithQuestions;

  TestController({required this.apiService, required this.loading, required this.notify});

  Future<bool?> addQuestion(QuestionCreateModel model) async {
    try {
      loading.show();
      final response = await apiService.post(
        endpoint: AppUrs.question,
        data:model.toJson(), fromJsonT: (Map<String, dynamic> p1) {  },
      );
      if (response.success) {
        response.data;
        notify.show(
          "Savol muvaffaqiyatli qo'shildi: ${response.data?.name} : ${response.data?.videoUrl}",
          NotifyType.success,
        );
        return true;
      } else {
        notify.show(
          "Ma'lumotlarni olishda xatolik: ${response.errorMessage}",
          NotifyType.warning,
        );
      }
    } catch (e) {
      notify.show("Xatolik yuz berdi: $e", NotifyType.error);
    } finally {
      loading.hide();
    }
    return null;
  }
  Future<bool?> getQuestionsByTestId(int testId) async {
    try {
      // loading.show();
      final response = await apiService.get<TestWithQuestions>(AppUrs.testWithQuestions(testId), TestWithQuestions.fromJson);
      if (response.success) {
        testWithQuestions = response.data;
        // notifyListeners();
        // notify.show(
        //   "Ma'lumotlar muvaffaqiyatli olindi",
        //   NotifyType.success,
        // );
        return true;
      } else {
        // notify.show(
        //   "Ma'lumotlarni olishda xatolik: ${response.errorMessage}",
        //   NotifyType.warning,
        // );
      }
    } catch (e) {
      notify.show("Xatolik yuz berdi: $e", NotifyType.error);
    } finally {
      // loading.hide();
    }
    return null;
  }
}