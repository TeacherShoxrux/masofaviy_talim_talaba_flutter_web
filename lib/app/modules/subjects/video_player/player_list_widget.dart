import 'package:flutter/material.dart';

class VideoListItemWidget extends StatelessWidget {
  final dynamic item; // VideoItem modeli yoki Map
  final VoidCallback onTap;
  final bool isSelected;

  const VideoListItemWidget({
    super.key,
    required this.item,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Video Icon/Thumbnail qismi
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    image: item.icon != "string" && item.icon.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(item.icon),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: item.icon == "string" || item.icon.isEmpty
                      ? const Icon(Icons.video_library, color: Colors.grey)
                      : null,
                ),
                if (isSelected)
                  const Icon(Icons.play_circle_fill, color: Colors.blue, size: 30),
              ],
            ),
            const SizedBox(width: 12),

            // 2. Video Ma'lumotlari
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected ? Colors.blue.shade900 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 3. Pastki statistika (View Count)
                  Row(
                    children: [
                      const Icon(Icons.remove_red_eye_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "${item.viewCount} marta ko'rilgan",
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}