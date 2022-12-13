class Shelter {
  final String city;
  final String code;
  final String building;
  final String coordinator;
  final String phoneNumber;
  final String capacity;
  final String lat;
  final String lon;

  const Shelter({
    required this.city,
    required this.code,
    required this.building,
    required this.coordinator,
    required this.phoneNumber,
    required this.capacity,
    required this.lat,
    required this.lon,
  });

  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
      city: json['ciudad'],
      code: json['codigo'],
      building: json['edificio'],
      coordinator: json['coordinador'],
      phoneNumber: json['telefono'],
      capacity: json['capacidad'],
      lat: json['lat'],
      lon: json['lng'],
    );
  }
}
