// lib/presentation/pages/post_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';
import '../../presentation/controllers/post_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailPage extends StatelessWidget {
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.find<PostController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yazı Detayı'),
      ),
      body: FutureBuilder<Post?>(
        future: controller
            .getPostById(postId)
            .then((either) => either.getOrElse(() => null)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          final Post? post = snapshot.data;

          if (post == null) {
            return const Center(child: Text('Yazı bulunamadı.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kapak Görseli
                    if (post.coverImage != null && post.coverImage!.isNotEmpty)
                      CachedNetworkImage(
                        imageUrl: post.coverImage!,
                        placeholder: (context, url) => Container(
                          height: 250,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 250,
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image,
                              size: 100, color: Colors.grey),
                        ),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    const SizedBox(height: 16),

                    // Başlık
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Oluşturulma Tarihi
                    Text(
                      'Oluşturulma Tarihi: ${post.createdAt.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // İçerik
                    Linkify(
                      onOpen: (link) async {
                        final Uri uri = Uri.parse(link.url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                        } else {
                          Get.snackbar('Hata', 'URL açılamadı.');
                        }
                      },
                      text: post.content,
                      style: const TextStyle(
                        fontSize: 18.0,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                      linkStyle: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      options: const LinkifyOptions(looseUrl: true),
                      textAlign: TextAlign.left,
                      //selectable: true,
                      maxLines: null,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
