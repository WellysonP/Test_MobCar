import 'package:dio/dio.dart';
import 'package:mobicar/models/brand_model.dart';
import '../models/vehicle_model.dart';

class VehicleService {
  final Dio dio;

  VehicleService({required this.dio});

  Future<List<VehicleModel>> getVehicle(BrandModel selectedBrand) async {
    final String brandInitial = selectedBrand.id;

    Response response = await dio.get(
        "https://parallelum.com.br/fipe/api/v1/carros/marcas/$brandInitial/modelos");
    final vehicles = response.data["modelos"] as List;
    final List<VehicleModel> vehicleList =
        vehicles.map((vehicle) => VehicleModel.fromJson(vehicle)).toList();
    return vehicleList;
  }
}
