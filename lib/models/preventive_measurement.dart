class PreventiveMeasurement {
  final String id;
  final String title;
  final String description;
  final String photoUrl;

  const PreventiveMeasurement({
    required this.id,
    required this.title,
    required this.description,
    required this.photoUrl,
  });

  factory PreventiveMeasurement.fromJson(Map<String, dynamic> json) {
    return PreventiveMeasurement(
      id: json['id'],
      title: json['titulo'],
      description: json['descripcion'],
      photoUrl: json['foto'],
    );
  }
}
