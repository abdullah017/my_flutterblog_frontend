import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';

/// The `PostModel` class extends `Post` and includes a constructor and a factory method for creating
/// instances from JSON data.
class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.title,
    required super.content,
    super.coverImage,
    required super.isPublished,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      coverImage: json['cover_image'],
      isPublished: json['is_published'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
