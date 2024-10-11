// lib/presentation/widgets/post_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';
import '../../presentation/pages/post_detail_page.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String getSnippet(String content, {int wordLimit = 30}) {
    final words = content.split(' ');
    if (words.length <= wordLimit) {
      return content;
    }
    return '${words.sublist(0, wordLimit).join(' ')}...';
  }

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');

    return GestureDetector(
      onTap: () {
        Get.to(() => PostDetailPage(postId: widget.post.id));
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kapak Görseli
                if (widget.post.coverImage != null &&
                    widget.post.coverImage!.isNotEmpty)
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl: widget.post.coverImage!,
                      placeholder: (context, url) => Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image,
                            size: 50, color: Colors.grey),
                      ),
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Başlık
                      Text(
                        widget.post.title,
                        style: GoogleFonts.lora(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Özet
                      Text(
                        getSnippet(widget.post.content),
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      // Yayın Tarihi
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            formatter.format(widget.post.createdAt),
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
