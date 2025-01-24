import 'package:booking/domain/domain.dart';

class FeedbackModel {
  final int id;
  final String title;
  final String content;
  final int rateNumber;
  final String authorIp;
  final String status;
  final DateTime createdAt;
  final int vendorId;
  final int authorId;

  FeedbackModel({
    required this.id,
    required this.title,
    required this.content,
    required this.rateNumber,
    required this.authorIp,
    required this.status,
    required this.createdAt,
    required this.vendorId,
    required this.authorId,
  });

  FeedbackEntity toEntity() {
    return FeedbackEntity(
      id: id,
      title: title,
      content: content,
      rateNumber: rateNumber,
      authorIp: authorIp,
      status: status,
      createdAt: createdAt,
      vendorId: vendorId,
      authorId: authorId,
    );
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      rateNumber: json['rate_number'] ?? 0,
      authorIp: json['author_ip'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      vendorId: json['vendor_id'] ?? 0,
      authorId: json['author_id'] ?? 0,
    );
  }
}
