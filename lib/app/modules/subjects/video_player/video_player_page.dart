import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/global/app_colors.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/player.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/player_list_widget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
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
                  Expanded(
                    child: Player(controller:_controller)
                  ),
                  if(MediaQuery.of(context).size.width>1200)VideoExpandableWidget(
                    title: 'Darslik videolari',
                    about: 'Videolarni barchasini etiboet bilan korib chiqing',
                    duration: '12',
                    videos: videos,
                    onVideoSelected: (VideoItem video) {
                      _controller.loadVideo(video.id);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Wrap(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(right: 8.0),
              //       child: IconButton(
              //         onPressed: () {
              //           _controller.previousVideo();
              //         },
              //         icon: Icon(Icons.skip_previous),
              //         style: btnStyle,
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 8.0),
              //       child: IconButton(
              //         onPressed: () {
              //           _controller.pauseVideo();
              //         },
              //         icon: Icon(Icons.pause),
              //         style: btnStyle,
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 8.0),
              //       child: IconButton(
              //         onPressed: () {
              //           _controller.playVideo();
              //         },
              //         icon: Icon(Icons.play_arrow),
              //         style: btnStyle,
              //       ),
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         _controller.nextVideo();
              //       },
              //       icon: Icon(Icons.skip_next),
              //       style: btnStyle,
              //     ),
              //   ],
              // ),
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

//
// class VideoCoursePage extends StatefulWidget {
//   @override
//   _VideoCoursePageState createState() => _VideoCoursePageState();
// }
//
// class _VideoCoursePageState extends State<VideoCoursePage> {
//   // --- Example playlist: videoId and title
//   final List<Map<String, String>> playlist = [
//     {'id': 'dQw4w9WgXcQ', 'title': 'Example Video 1'}, // sample id
//     {'id': 'kJQP7kiw5Fk', 'title': 'Example Video 2'},
//     {'id': '3JZ_D3ELwOQ', 'title': 'Example Video 3'},
//   ];
//
//   late YoutubePlayerController _ytController;
//   int currentIndex = 0;
//   bool isPlayerReady = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _ytController = YoutubePlayerController(
//       // initialVideoId: playlist[currentIndex]['id']!,
//       params: YoutubePlayerParams(
//         showControls: false, // we'll create custom controls
//         showFullscreenButton: true,
//         // autoPlay: false,
//         enableJavaScript: true,
//         // privacyEnhanced: true,
//       ),
//     );
//
//     // Optional: listen to changes
//     _ytController.onInit = () {
//       setState(() {
//         isPlayerReady = true;
//       });
//     };
//
//     // Listen to player state to update UI (play/pause)
//     _ytController.listen((value) {
//       // This callback happens frequently; use setState selectively
//       // We'll update minimal state only when needed.
//       // For demo, we don't change UI every tick.
//     });
//   }
//
//   @override
//   void dispose() {
//     _ytController.close();
//     super.dispose();
//   }
//
//   // Helper actions
//   void _play() => _ytController.play();
//   void _pause() => _ytController.pause();
//   void _stop() {
//     _ytController.pause();
//     _ytController.seekTo(Duration.zero);
//   }
//
//   void _next() {
//     if (currentIndex < playlist.length - 1) {
//       currentIndex++;
//       _loadCurrent();
//     }
//   }
//
//   void _prev() {
//     if (currentIndex > 0) {
//       currentIndex--;
//       _loadCurrent();
//     }
//   }
//
//   void _seekForwardSeconds(int sec) async {
//     final pos = await _ytController.currentTime;
//     _ytController.seekTo(Duration(milliseconds: (pos * 1000).toInt()) + Duration(seconds: sec));
//   }
//
//   void _seekBackwardSeconds(int sec) async {
//     final pos = await _ytController.currentTime;
//     final newPos = (pos - sec) < 0 ? 0.0 : (pos - sec);
//     _ytController.seekTo(Duration(milliseconds: (newPos * 1000).toInt()));
//   }
//
//   void _loadCurrent() {
//     final id = playlist[currentIndex]['id']!;
//     _ytController.load(id);
//     setState(() {});
//   }
//
//   void _openAtIndex(int idx) {
//     if (idx < 0 || idx >= playlist.length) return;
//     currentIndex = idx;
//     _loadCurrent();
//   }
//
//   // Simple getter for current video title
//   String get currentTitle => playlist[currentIndex]['title'] ?? '';
//
//   @override
//   Widget build(BuildContext context) {
//     // Responsive layout: sidebar on wide screens, bottom sheet on narrow screens
//     final isWide = MediaQuery.of(context).size.width >= 900;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Darslik: Video darslar'),
//         backgroundColor: Colors.blueGrey.shade900,
//       ),
//       body: SafeArea(
//         child: Row(
//           children: [
//             // --- LEFT: Playlist (on wide) OR hidden on mobile
//             if (isWide)
//               Container(
//                 width: 320,
//                 color: Colors.grey.shade100,
//                 child: _buildPlaylist(),
//               ),
//
//             // --- RIGHT/Main: Player + Controls + Description
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Player box (aspect ratio)
//                       AspectRatio(
//                         aspectRatio: 16 / 9,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Container(
//                             color: Colors.black,
//                             child: YoutubePlayerControllerProvider(
//                               // Provides controller to widget tree.
//                               controller: _ytController,
//                               child: YoutubePlayerIFrame(),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       SizedBox(height: 12),
//
//                       // Title + controls row
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               currentTitle,
//                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                             ),
//                           ),
//
//                           // Play / Pause / Stop / Prev / Next Buttons
//                           _buildControlButton(Icons.skip_previous, 'Oldingi', _prev),
//                           SizedBox(width: 6),
//                           _buildControlButton(Icons.replay_10, '-10s', () => _seekBackwardSeconds(10)),
//                           SizedBox(width: 6),
//                           _buildControlButton(Icons.play_arrow, 'Play', _play),
//                           SizedBox(width: 6),
//                           _buildControlButton(Icons.pause, 'Pause', _pause),
//                           SizedBox(width: 6),
//                           _buildControlButton(Icons.stop, 'Stop', _stop),
//                           SizedBox(width: 6),
//                           _buildControlButton(Icons.forward_10, '+10s', () => _seekForwardSeconds(10)),
//                           SizedBox(width: 6),
//                           _buildControlButton(Icons.skip_next, 'Keyingi', _next),
//                         ],
//                       ),
//
//                       SizedBox(height: 12),
//
//                       // Progress + current time / duration (basic)
//                       FutureBuilder<Duration>(
//                         future: _ytController.videoDuration,
//                         builder: (context, snapDur) {
//                           final total = snapDur.data ?? Duration.zero;
//                           return StreamBuilder<PlayerState>(
//                             stream: _ytController.playerStateStream,
//                             builder: (context, snapState) {
//                               // We will read currentTime via future each time user refreshes;
//                               // For a lightweight demo, we show basic info.
//                               return FutureBuilder<double>(
//                                 future: _ytController.currentTime,
//                                 builder: (context, snapPos) {
//                                   final posSeconds = snapPos.data ?? 0.0;
//                                   final cur = Duration(milliseconds: (posSeconds * 1000).toInt());
//                                   final totalText = _formatDuration(total);
//                                   final curText = _formatDuration(cur);
//
//                                   double progress = 0.0;
//                                   if (total.inMilliseconds > 0) {
//                                     progress = cur.inMilliseconds / total.inMilliseconds;
//                                     if (progress < 0) progress = 0.0;
//                                     if (progress > 1) progress = 1.0;
//                                   }
//
//                                   return Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       LinearProgressIndicator(value: progress),
//                                       SizedBox(height: 6),
//                                       Text('$curText / $totalText', style: TextStyle(color: Colors.black54)),
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                           );
//                         },
//                       ),
//
//                       SizedBox(height: 18),
//
//                       // Description or lesson text
//                       Text(
//                         'Dars tavsifi',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Bu darslikdagi videolar kurs tartibida joylangan. Pastdagi playlistdan keraklisini tanlab o\'ynatishingiz mumkin. Player ustidagi tugmalar orqali pauza, play, stop va 10 soniya oldinga/orqaga o\'tishingiz mumkin.',
//                         style: TextStyle(color: Colors.black87),
//                       ),
//
//                       // On narrow screens show playlist button
//                       if (!isWide) ...[
//                         SizedBox(height: 24),
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             _showPlaylistBottomSheet(context);
//                           },
//                           icon: Icon(Icons.playlist_play),
//                           label: Text('Videolar ro\'yhati'),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildControlButton(IconData icon, String tooltip, VoidCallback onTap) {
//     return Tooltip(
//       message: tooltip,
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blueGrey.shade800,
//           minimumSize: Size(40, 40),
//           padding: EdgeInsets.zero,
//         ),
//         child: Icon(icon, size: 20),
//       ),
//     );
//   }
//
//   Widget _buildPlaylist() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 12),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12),
//           child: Text('Videolar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//         ),
//         SizedBox(height: 8),
//         Expanded(
//           child: ListView.separated(
//             itemCount: playlist.length,
//             separatorBuilder: (_, __) => Divider(height: 1),
//             itemBuilder: (context, idx) {
//               final item = playlist[idx];
//               final isActive = idx == currentIndex;
//               return ListTile(
//                 selected: isActive,
//                 selectedColor: Colors.white,
//                 tileColor: isActive ? Colors.blue.shade50 : null,
//                 leading: Container(
//                   width: 84,
//                   height: 48,
//                   color: Colors.black12,
//                   alignment: Alignment.center,
//                   child: Icon(Icons.play_circle_fill, color: Colors.redAccent),
//                 ),
//                 title: Text(item['title'] ?? ''),
//                 subtitle: Text('ID: ${item['id']}'),
//                 trailing: isActive ? Icon(Icons.check_circle, color: Colors.blue) : null,
//                 onTap: () {
//                   _openAtIndex(idx);
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _showPlaylistBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (ctx) {
//         return SizedBox(
//           height: 420,
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(12),
//                 child: Text('Videolar ro\'yhati', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//               ),
//               Expanded(
//                 child: ListView.separated(
//                   itemCount: playlist.length,
//                   separatorBuilder: (_, __) => Divider(height: 1),
//                   itemBuilder: (_, idx) {
//                     final item = playlist[idx];
//                     return ListTile(
//                       leading: Icon(Icons.video_library),
//                       title: Text(item['title'] ?? ''),
//                       onTap: () {
//                         Navigator.of(ctx).pop();
//                         _openAtIndex(idx);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   String _formatDuration(Duration d) {
//     String two(int n) => n.toString().padLeft(2, '0');
//     final mm = two(d.inMinutes.remainder(60));
//     final ss = two(d.inSeconds.remainder(60));
//     final hh = d.inHours;
//     if (hh > 0) {
//       return '$hh:$mm:$ss';
//     }
//     return '$mm:$ss';
//   }
// }
