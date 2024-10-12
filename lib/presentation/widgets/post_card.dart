// lib/presentation/widgets/post_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_blogapp_frontend/core/helper/route_slug_helper.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';
import 'package:my_blogapp_frontend/routes/app_pages.dart';

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
        final String slugifiedTitle =
            RouteSlugHelper().slugify(widget.post.title);
        Get.toNamed('${Routes.post_detail}/$slugifiedTitle-${widget.post.id}');
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
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Card(
            color: Theme.of(context).cardColor,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                        color: Theme.of(context).colorScheme.surface,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) {
                        print('CachedNetworkImage error: $error');
                        return Container(
                          height: 150,
                          color: Theme.of(context).colorScheme.surface,
                          child: const Icon(Icons.broken_image,
                              size: 50, color: Colors.grey),
                        );
                      },
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  // Varsayılan bir kapak resmi göster
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      'assets/images/default_cover.png', // Projenize uygun varsayılan resim ekleyin
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
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Özet
                      Text(
                        getSnippet(widget.post.content),
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 14,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      // Yayın Tarihi
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16,
                              color: Theme.of(context).iconTheme.color),
                          const SizedBox(width: 4),
                          Text(
                            formatter.format(widget.post.createdAt),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
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
