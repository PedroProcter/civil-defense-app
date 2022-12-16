class Situation {
  final String id;
  final String title;
  final String description;
  final String photoBase64;
  final String status;
  final String date;
  final String lat;
  final String lon;

  const Situation({
    required this.id,
    required this.title,
    required this.description,
    required this.photoBase64,
    required this.status,
    required this.date,
    required this.lat,
    required this.lon,
  });

  factory Situation.fromJson(Map<String, dynamic> json) {
    return Situation(
      id: json['id'],
      title: json['titulo'],
      description: json['descripcion'],
      photoBase64: json['foto'],
      status: json['estado'],
      date: json['fecha'],
      lat: json['latitud'],
      lon: json['longitud'],
    );
  }
}
