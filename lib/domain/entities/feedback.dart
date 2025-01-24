class FeedbackEntity {
  final int id;
  final String title;
  final String content;
  final int rateNumber;
  final String authorIp;
  final String status;
  final DateTime createdAt;
  final int vendorId;
  final int authorId;

  FeedbackEntity({
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
}
