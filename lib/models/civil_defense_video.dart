class CivilDefenseVideo {
  final String id;
  final String date;
  final String title;
  final String description;
  final String code;

  const CivilDefenseVideo({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.code,
  });

  factory CivilDefenseVideo.fromJson(Map<String, dynamic> json) {
    return CivilDefenseVideo(
      id: '${json['id']}',
      date: '${json['fecha']}',
      title: '${json['titulo']}',
      description: '${json['descripcion']}',
      code: '${json['link']}',
    );
  }
}
