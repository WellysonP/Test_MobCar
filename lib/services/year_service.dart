import 'package:dio/dio.dart';
import 'package:mobicar/models/brand_model.dart';
import 'package:mobicar/models/vehicle_model.dart';
import 'package:mobicar/models/year_model.dart';

class YearService {
  final Dio dio;

  YearService({required this.dio});

  Future<List<YearModel>> getYear(
      BrandModel selectedBrand, VehicleModel selectedVehicle) async {
    final String brandInitial = selectedBrand.id;
    final String vehicleInitial = selectedVehicle.id;

    Response response = await dio.get(
        "https://parallelum.com.br/fipe/api/v1/carros/marcas/$brandInitial/modelos/$vehicleInitial/anos");
    final years = response.data as List;
    final List<YearModel> yearList =
        years.map((Year) => YearModel.fromJson(Year)).toList();
    return yearList;
  }
}
