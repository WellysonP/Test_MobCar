// ignore_for_file: public_member_api_docs, sort_constructors_first
class YearModel {
  const YearModel({
    required this.id,
    required this.name,
  });

  factory YearModel.fromJson(Map<String, dynamic> map) {
    return YearModel(
      id: map['codigo'] ?? '',
      name: map['nome'] ?? '',
    );
  }

  final String id;
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YearModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
