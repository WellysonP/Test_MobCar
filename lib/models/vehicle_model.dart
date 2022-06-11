// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
