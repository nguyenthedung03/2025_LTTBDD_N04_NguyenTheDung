class Comment {
  final String author;
  final String text;
  final DateTime createdAt;

  Comment(
      {required this.author, required this.text})
      : createdAt = DateTime.now();
}
