class Member {
  final String id;
  final String name;
  final String position;
  final String photoUrl;

  const Member({
    required this.id,
    required this.name,
    required this.position,
    required this.photoUrl,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['nombre'],
      position: json['cargo'],
      photoUrl: json['foto'],
    );
  }
}
