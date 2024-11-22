import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class PostModel {
  final int id;
  final String slug;
  final String title;
  final String image;
  final String content;
  final CategoryModel category;
  final UserModel author;

  PostModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.image,
    required this.content,
    required this.category,
    required this.author,
  });

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      slug: slug,
      title: title,
      image: image,
      content: content,
      category: category.toEntity(),
      author: author.toEntity(),
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      content: json['content'] ?? '',
      category: CategoryModel.fromJson(json['category'] ?? {}),
      author: UserModel.fromJson({"user": json['author']}),
    );
  }
}
