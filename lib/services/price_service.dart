import 'package:dio/dio.dart';
import 'package:mobicar/models/brand_model.dart';
import 'package:mobicar/models/car_data_model.dart';
import 'package:mobicar/models/vehicle_model.dart';
import 'package:mobicar/models/year_model.dart';

class PriceService {
  final Dio dio;

  PriceService({required this.dio});

  Future<List<CarDataModel>> getCarData(
    BrandModel selectedBrand,
    VehicleModel selectedVehicle,
    YearModel selectedYear,
  ) async {
    final String brandInitial = selectedBrand.id;
    final String vehicleInitial = selectedVehicle.id;
    final String yearInitial = selectedYear.id;

    Response response = await dio.get(
        "https://parallelum.com.br/fipe/api/v1/carros/marcas/$brandInitial/modelos/$vehicleInitial/anos/$yearInitial");
    final carDatas = response.data as Map<String, dynamic>;
    final carDataList = CarDataModel.fromJson(carDatas);
    // final List<CarDataModel> carDataList =
    //     carDatas.map((carData) => CarDataModel.fromJson(carData)).toList();
    return [carDataList];
  }
}
