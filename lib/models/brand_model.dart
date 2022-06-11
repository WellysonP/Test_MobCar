import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BrandModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
