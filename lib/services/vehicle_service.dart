import 'package:dio/dio.dart';
import 'package:mobicar/models/brand_model.dart';

import '../models/vehicle_model.dart';

class VehicleService {
  final Dio dio;

  VehicleService({required this.dio});

  Future<List<VehicleModel>> getBrand(BrandModel brand) async {
    final String brandInitial = brand.id;
    // listCarBrand.clear();
    Response response =
        await dio.get("https://parallelum.com.br/fipe/api/v1/carros/marcas");
    // for (int i = 0; i < response.data.length; i++) {
    //   List itemCarBrand = [response.data[i]["nome"]];
    //   listCarBrand += itemCarBrand;
    // }
    final vehicles = response.data as List;
    final List<VehicleModel> vehicleList =
        vehicles.map((brand) => VehicleModel.fromJson(brand)).toList();
    print(vehicleList);
    return vehicleList;
  }
}
