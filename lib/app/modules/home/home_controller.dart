import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/home/model/statistics_model.dart';

import '../../Services/api_client_service.dart';
import '../../global/app_urs.dart';
import '../../global/base_response.dart';
import '../loading/loading_controller.dart';
import '../notification/notification_controller.dart';

class HomeController extends ChangeNotifier {
  final ApiService apiService;
  final LoadingController loading;
  final NotificationController notify;
  StatisticsModel? statisticsModel;
  HomeController( {required this.apiService, required this.loading, required this.notify});

  Future<void> getDetail() async {
    try {
      loading.show();

      final response = await apiService.get<StatisticsModel>(AppUrs.dashboard,StatisticsModel.fromJson);
      if (response.success) {
        statisticsModel = response.data;
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