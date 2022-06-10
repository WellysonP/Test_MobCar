class VehicleModel {
  final String id;
  final String name;

  const VehicleModel({
    required this.id,
    required this.name,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['codigo'].toString(),
      name: map['nome'] ?? '',
    );
  }
}
