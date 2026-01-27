import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/global/app_colors.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/components/video_model.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/player.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/player_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../components/subject_controller.dart';

class VideoItem {
  final String id;
  final String title;
  final String about;
  final String duration;

  VideoItem({
    required this.id,
    required this.title,
    required this.about,
    required this.duration,
  });
}

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key, this.id});
  final String? id;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  final btnStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
  );
  final _controller = YoutubePlayerController.fromVideoId(
    videoId:
        YoutubePlayerController.convertUrlToId(
          "https://www.youtube.com/watch?v=bk-UboxN760&list=RDbk-UboxN760&start_radio=1",
        ) ??
        "iLnmTe5Q2Qw",
    // 'iLnmTe5Q2Qw',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  final videos = [
    VideoItem(
      id: "https://www.youtube.com/watch?v=zYV8s7XsWbE&list=RDzYV8s7XsWbE&start_radio=1",
      title: "Flutter Lesson 1",
      about: "Intro to Flutter widgets and structure.",
      duration: "12:04",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=bHLiD72xpDM&list=RDbHLiD72xpDM&start_radio=1",
      title: "Flutter State Management",
      about: "Stateful widgets explained.",
      duration: "18:21",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=RqKY_fNqkos&list=RDRqKY_fNqkos&start_radio=1",
      title: "Flutter Navigation",
      about: "go_router navigation tutorial.",
      duration: "22:10",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=zYV8s7XsWbE&list=RDzYV8s7XsWbE&start_radio=1",
      title: "Flutter Lesson 1",
      about: "Intro to Flutter widgets and structure.",
      duration: "12:04",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=bHLiD72xpDM&list=RDbHLiD72xpDM&start_radio=1",
      title: "Flutter State Management",
      about: "Stateful widgets explained.",
      duration: "18:21",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=RqKY_fNqkos&list=RDRqKY_fNqkos&start_radio=1",
      title: "Flutter Navigation",
      about: "go_router navigation tutorial.",
      duration: "22:10",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=zYV8s7XsWbE&list=RDzYV8s7XsWbE&start_radio=1",
      title: "Flutter Lesson 1",
      about: "Intro to Flutter widgets and structure.",
      duration: "12:04",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=bHLiD72xpDM&list=RDbHLiD72xpDM&start_radio=1",
      title: "Flutter State Management",
      about: "Stateful widgets explained.",
      duration: "18:21",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=RqKY_fNqkos&list=RDRqKY_fNqkos&start_radio=1",
      title: "Flutter Navigation",
      about: "go_router navigation tutorial.",
      duration: "22:10",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=zYV8s7XsWbE&list=RDzYV8s7XsWbE&start_radio=1",
      title: "Flutter Lesson 1",
      about: "Intro to Flutter widgets and structure.",
      duration: "12:04",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=bHLiD72xpDM&list=RDbHLiD72xpDM&start_radio=1",
      title: "Flutter State Management",
      about: "Stateful widgets explained.",
      duration: "18:21",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=RqKY_fNqkos&list=RDRqKY_fNqkos&start_radio=1",
      title: "Flutter Navigation",
      about: "go_router navigation tutorial.",
      duration: "22:10",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=zYV8s7XsWbE&list=RDzYV8s7XsWbE&start_radio=1",
      title: "Flutter Lesson 1",
      about: "Intro to Flutter widgets and structure.",
      duration: "12:04",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=bHLiD72xpDM&list=RDbHLiD72xpDM&start_radio=1",
      title: "Flutter State Management",
      about: "Stateful widgets explained.",
      duration: "18:21",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=RqKY_fNqkos&list=RDRqKY_fNqkos&start_radio=1",
      title: "Flutter Navigation",
      about: "go_router navigation tutorial.",
      duration: "22:10",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=zYV8s7XsWbE&list=RDzYV8s7XsWbE&start_radio=1",
      title: "Flutter Lesson 1",
      about: "Intro to Flutter widgets and structure.",
      duration: "12:04",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=bHLiD72xpDM&list=RDbHLiD72xpDM&start_radio=1",
      title: "Flutter State Management",
      about: "Stateful widgets explained.",
      duration: "18:21",
    ),
    VideoItem(
      id: "https://www.youtube.com/watch?v=RqKY_fNqkos&list=RDRqKY_fNqkos&start_radio=1",
      title: "Flutter Navigation",
      about: "go_router navigation tutorial.",
      duration: "22:10",
    ),
  ];
@override
void initState(){
  context.read<SubjectController>().getVideoById(widget.id!);
    super.initState();
  }
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var controller = context.watch<SubjectController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Videolarni ko'rsih joyi"),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<VideoModel?>(
                    builder: (context,snapshot) {
                         if(snapshot.connectionState==ConnectionState.waiting) {
                           return CircularProgressIndicator.adaptive();
                         }
                      return Expanded(
                        child: Player(controller:_controller)
                      );
                    }, future: controller.getVideoById(widget.id),
                  ),
                  if(MediaQuery.of(context).size.width>1200)VideoExpandableWidget(
                    title: 'Darslik videolari',
                    about: 'Videolarni barchasini etiboet bilan korib chiqing',
                    duration: '12',
                    videos: videos,
                    onVideoSelected: (VideoItem video) {
                      // _controller.loadVideo(video.id);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              if(MediaQuery.of(context).size.width<=1200)VideoExpandableWidget(
                title: 'Darslik videolari', about: 'Videolarni barchasini etiboet bilan korib chiqing', duration: '12', videos: videos,
                onVideoSelected: (VideoItem video) {
                  _controller.loadVideo(video.id);
                },)
            ],
          ),
        ),
      ),
    );
  }
}
