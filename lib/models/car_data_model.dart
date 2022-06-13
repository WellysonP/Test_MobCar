// ignore_for_file: public_member_api_docs, sort_constructors_first
class CarDataModel {
  CarDataModel({
    required this.price,
    required this.brand,
    required this.model,
    required this.year,
    required this.fuelType,
    required this.fipeCode,
    required this.monthRef,
  });

  factory CarDataModel.fromJson(Map<String, dynamic> map) {
    return CarDataModel(
      price: map['Valor'] ?? '',
      brand: map['Marca'] ?? '',
      model: map['Modelo'] ?? '',
      year: map['AnoModelo'].toString(),
      fuelType: map['Combustivel'] ?? '',
      fipeCode: map['CodigoFipe'] ?? '',
      monthRef: map['MesReferencia'] ?? '',
    );
  }

  final String price;
  final String brand;
  final String model;
  final String year;
  final String fuelType;
  final String fipeCode;
  final String monthRef;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarDataModel &&
        other.price == price &&
        other.brand == brand &&
        other.model == model &&
        other.year == year &&
        other.fuelType == fuelType &&
        other.fipeCode == fipeCode &&
        other.monthRef == monthRef;
  }

  @override
  int get hashCode {
    return price.hashCode ^
        brand.hashCode ^
        model.hashCode ^
        year.hashCode ^
        fuelType.hashCode ^
        fipeCode.hashCode ^
        monthRef.hashCode;
  }
}
