import 'package:masofaviy_talim_talaba/app/modules/subjects/models/reference_model.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/models/subject_model.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/models/test_models.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/models/video_model.dart';

import 'crossword_model.dart';
import 'independent_work.dart';

class SubjectDetails {
  final SubjectModel subject;
  final List<IndependentWork> independentWorks;
  final List<VideoLesson> videos;
  final List<CrossWord> crossWords;
  final List<ReferenceItem> references;
  final List<TestItem> tests;

  SubjectDetails({
    required this.subject,
    required this.independentWorks,
    required this.videos,
    required this.crossWords,
    required this.references,
    required this.tests,
  });

  factory SubjectDetails.fromJson(Map<String, dynamic> json) {
    return SubjectDetails(
      subject: SubjectModel.fromJson(json['subject']),
      independentWorks: (json['independentWorks'] as List<dynamic>)
          .map((e) => IndependentWork.fromJson(e))
          .toList(),
      videos: (json['videos'] as List<dynamic>)
          .map((e) => VideoLesson.fromJson(e))
          .toList(),
      crossWords: (json['crossWords'] as List<dynamic>)
          .map((e) => CrossWord.fromJson(e))
          .toList(),
      references: (json['references'] as List<dynamic>)
          .map((e) => ReferenceItem.fromJson(e))
          .toList(),
      tests: (json['tests'] as List<dynamic>)
          .map((e) => TestItem.fromJson(e))
          .toList(),
    );
  }
}
