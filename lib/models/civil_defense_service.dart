class CivilDefenseService {
  final String id;
  final String name;
  final String description;
  final String photoUrl;

  const CivilDefenseService({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
  });

  factory CivilDefenseService.fromJson(Map<String, dynamic> json) {
    return CivilDefenseService(
      id: json['id'],
      name: json['nombre'],
      description: json['descripcion'],
      photoUrl: json['foto'],
    );
  }
}
