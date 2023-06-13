class Article {
  final int id;
  final String title;
  final String imageUrl;
  final String content;

  Article({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'content': content,
    };
  }
}
