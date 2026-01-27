import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masofaviy_talim_talaba/app/global/app_colors.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/player.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/player_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../components/subject_controller.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key, this.id});
  final String? id;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  int? currentPlayingId;

  @override
  void initState() {
    currentPlayingId=int.parse(widget.id??"0");
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        mute: false,
        showControls: true,
      ),
    );


    // Ma'lumotlarni yuklash
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id != null) {
       var subjectId = GoRouterState.of(context).pathParameters['subject_id'];
       context.read<SubjectController>().getAllVideosBySubjectId(subjectId).then((v) {
          final videos = context.read<SubjectController>().videos;
          if (videos.isNotEmpty) {
            _playVideo(videos.first.videoUrl, videos.first.id);
          }
        });
      }
    });
  }

  // Videoni pleyerda yuklash funksiyasi
  void _playVideo(String url, int id) {
    Future.microtask((){context.read<SubjectController>().getVideoById(id.toString());});
    final videoId = YoutubePlayerController.convertUrlToId(url);
    if (videoId != null) {
      _controller.loadVideoById(videoId: videoId);
      setState(() {
        currentPlayingId = id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final subjectController = context.watch<SubjectController>();
    final isDesktop = MediaQuery.of(context).size.width > 1200;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Video darslik"),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: isDesktop ? _buildDesktopLayout(subjectController) : _buildMobileLayout(subjectController),
          );
        },
      ),
    );
  }

  // Desktop ko'rinishi: Video chapda, List o'ngda
  Widget _buildDesktopLayout(SubjectController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Player(controller: _controller),
              const SizedBox(height: 20),
              _buildVideoInfo(controller),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: _buildVideoList(controller),
        ),
      ],
    );
  }

  // Mobile ko'rinishi: Video tepada, List pastda
  Widget _buildMobileLayout(SubjectController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Player(controller: _controller),
          const SizedBox(height: 20),
          _buildVideoInfo(controller),
          const Divider(height: 40),
          const Text("Barcha darslar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildVideoList(controller, isScrollable: false),
        ],
      ),
    );
  }

  // Video ro'yxati vidgeti
  Widget _buildVideoList(SubjectController controller, {bool isScrollable = true}) {
    if (controller.videos.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
      shrinkWrap: !isScrollable,
      physics: isScrollable ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
      itemCount: controller.videos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final video = controller.videos[index];
        return VideoListItemWidget(
          item: video,
          isSelected: currentPlayingId == video.id,
          onTap: () => _playVideo(video.videoUrl, video.id),
        );
      },
    );
  }

  // Tanlangan video haqida ma'lumot (Pastki qism)
  Widget _buildVideoInfo(SubjectController controller) {
    if (currentPlayingId == null) return const SizedBox();

    // Hozirgi videoni topish
    final currentVideo = controller.videos.firstWhere((v) => v.id == currentPlayingId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentVideo.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          currentVideo.description ?? "Tavsif mavjud emas",
          style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.close(); // Xotirani tozalash
    super.dispose();
  }
}