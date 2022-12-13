class News {
  final String id;
  final String date;
  final String title;
  final String content;
  final String photoUrl;

  const News({
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.photoUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      date: json['fecha'],
      title: json['titulo'],
      content: json['contenido'],
      photoUrl: json['foto'],
    );
  }
}
