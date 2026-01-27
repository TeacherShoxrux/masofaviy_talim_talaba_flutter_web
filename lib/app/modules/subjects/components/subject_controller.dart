import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/components/video_model.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/models/subject_model.dart';
import '../../../Services/api_client_service.dart';
import '../../../global/app_urs.dart';
import '../../loading/loading_controller.dart';
import '../../notification/notification_controller.dart';
import '../models/subject_details.dart';

class SubjectController extends ChangeNotifier {
  final ApiService apiService;
  final LoadingController loading;
  final NotificationController notify;

  List<SubjectModel> subjects=List.empty();
  List<VideoModel> videos=List.empty();

  SubjectDetails? details;
  SubjectController( {required this.apiService, required this.loading, required this.notify});

  Future<void> getSubjectList() async {
    try {
      loading.show();
      final response = await apiService.getList<SubjectModel>(AppUrs.subjectsAll(),SubjectModel.fromJson);
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

  Future<void> getSubjectDetailsById(String id) async {
    try {
      loading.show();
      final response = await apiService.get<SubjectDetails>(AppUrs.subjectDetails(id),SubjectDetails.fromJson);
      if (response.success) {
        details = response.data;
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
      notifyListeners();
    }}

  Future<VideoModel?> getVideoById(String? id) async {
    try {
      loading.show();
      final response = await apiService.get<VideoModel>(AppUrs.video(id),VideoModel.fromJson);
      if (response.success) {
        return response.data;
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
    }
    return null;}
  Future<void> getAllVideosBySubjectId(String? id) async {
    try {
      loading.show();
      final response = await apiService.getList<VideoModel>(AppUrs.videoAllVideoSubjectId(id),VideoModel.fromJson);
      if (response.success) {
        videos= response.data;
        notifyListeners();
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
    }
  }

  Future<bool?> addVideoById({required String name, required String videoUrl, required String videoDetail,required String? subjectId,String? icon}) async {
    try {
      loading.show();
      final response = await apiService.post(endpoint: AppUrs.videoCreate, data: {
        "subjectId": int.parse(subjectId!),
        "icon": icon??"icons",
        "name": name,
        "description": videoDetail,
        "videoUrl":  videoUrl
      }, fromJsonT: VideoModel.fromJson);
      if (response.success) {
       response.data;
       notify.show(
         "Video muvaffaqiyatli qo'shildi: ${response.data?.name} : ${response.data?.videoUrl}",
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
      notify.show(
        "Xatolik yuz berdi: $e",
        NotifyType.error,
      );
    } finally {
      loading.hide();
    }
    return null;
  }

}