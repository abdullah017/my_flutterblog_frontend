// lib/domain/entities/post.dart
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String content;
  final String? coverImage;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Post({
    required this.id,
    required this.title,
    required this.content,
    this.coverImage,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        coverImage,
        isPublished,
        createdAt,
        updatedAt,
      ];
}
