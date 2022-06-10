class BrandModel {
  final String id;
  final String name;

  const BrandModel({
    required this.id,
    required this.name,
  });

  factory BrandModel.fromJson(Map<String, dynamic> map) {
    return BrandModel(
      id: map['codigo'] ?? '',
      name: map['nome'] ?? '',
    );
  }
}
