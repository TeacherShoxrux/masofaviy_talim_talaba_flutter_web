import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
class Player extends StatelessWidget {
  const Player({super.key, required this.controller});
  final YoutubePlayerController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(

        color: Colors.grey.shade300,
        // border:Border.all()
      ),
      child: YoutubePlayer(
        controller: controller,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
