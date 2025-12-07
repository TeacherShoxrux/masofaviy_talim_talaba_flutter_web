import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masofaviy_talim_talaba/app/modules/subjects/video_player/video_player_page.dart';

class VideoExpandableWidget extends StatefulWidget {
  final String title;
  final String about;
  final String duration;
  final List<VideoItem> videos;   // VideoItem modeldan foydalaning
  final Function(VideoItem video) onVideoSelected;

  const VideoExpandableWidget({
    super.key,
    required this.title,
    required this.about,
    required this.duration,
    required this.videos,
    required this.onVideoSelected,
  });

  @override
  State<VideoExpandableWidget> createState() => _VideoExpandableWidgetState();
}

class _VideoExpandableWidgetState extends State<VideoExpandableWidget>
    with SingleTickerProviderStateMixin {
  bool expanded = true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          InkWell(
            onTap: () => setState(() => expanded = !expanded),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Icon(
                    expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 26,
                  )
                ],
              ),
            ),
          ),

          // 🔽 Expandable qismi
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: expanded
                ? Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video description
                  Text(
                    widget.about,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "Duration: ${widget.duration}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.blueGrey,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // 🔵 Videolar ro‘yxati
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.videos.length,
                    itemBuilder: (context, index) {
                      final item = widget.videos[index];
                      final isSelected = index == selectedIndex;

                      return InkWell(
                        onTap: () {
                          setState(() => selectedIndex = index);
                          widget.onVideoSelected(item);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isSelected
                                ? Colors.blue.shade50
                                : Colors.grey.shade100,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.play_circle_fill,
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),

                              Text(
                                item.duration,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}