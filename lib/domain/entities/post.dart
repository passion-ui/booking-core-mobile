import 'package:booking/domain/domain.dart';

class PostEntity {
  final int id;
  final String slug;
  final String title;
  final String image;
  final String content;
  final String createdAt;
  final String url;
  final CategoryEntity category;
  final UserEntity author;

  PostEntity({
    required this.id,
    required this.slug,
    required this.title,
    required this.image,
    required this.content,
    required this.createdAt,
    required this.url,
    required this.category,
    required this.author,
  });
}
