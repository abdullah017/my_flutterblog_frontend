// lib/presentation/pages/post_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_blogapp_frontend/core/helper/text_capitalize_helper.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';
import '../../controllers/post_controller/post_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;
  final String title;

  const PostDetailPage({super.key, required this.postId, required this.title});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.find<PostController>();
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalize(widget
              .title), // Slug için değişen başlık kısmını tekrar düzenleme
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.appBarTheme.titleTextStyle?.color,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        iconTheme: theme.appBarTheme.iconTheme,
        centerTitle: true,
      ),
      body: FutureBuilder<Post?>(
        future: controller
            .getPostById(widget.postId)
            .then((either) => either.getOrElse(() => null)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
              'Hata: ${snapshot.error}',
              style: theme.textTheme.bodyLarge,
            ));
          }

          final Post? post = snapshot.data;

          if (post == null) {
            return Center(
                child: Text(
              'Yazı bulunamadı.',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 18,
              ),
            ));
          }

          return Scrollbar(
            controller: _scrollController,
            thumbVisibility: true, // Scrollbar'ı her zaman görünür yapar
            thickness: 8.0, // Scrollbar kalınlığı
            radius: const Radius.circular(4), // Scrollbar köşe yuvarlaklığı
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kapak Görseli
                      if (post.coverImage != null &&
                          post.coverImage!.isNotEmpty)
                        CachedNetworkImage(
                          imageUrl: post.coverImage!,
                          placeholder: (context, url) => const SizedBox(
                            height: 250,
                            child: Center(child: CircularProgressIndicator()),
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
                        )
                      else
                        // Varsayılan bir kapak resmi göster
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15)),
                          child: Image.asset(
                            'assets/images/default_cover.png', // Projenize uygun varsayılan resim ekleyin
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 16),

                      // Başlık
                      SelectableText(
                        post.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Oluşturulma Tarihi
                      Text(
                        'Oluşturulma Tarihi: ${post.createdAt.toLocal().toString().split(' ')[0]}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDarkMode
                              ? Colors.white70
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // İçerik
                      SelectableLinkify(
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
                        style: GoogleFonts.openSans(
                          textStyle: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 18.0,
                            height: 1.6,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                        linkStyle: TextStyle(
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                        options: const LinkifyOptions(looseUrl: true),
                        textAlign: TextAlign.left,
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
