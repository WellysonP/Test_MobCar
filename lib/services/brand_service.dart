import 'package:dio/dio.dart';
import '../models/brand_model.dart';

class BrandService {
  final Dio dio;

  BrandService({required this.dio});

  Future<List<BrandModel>> getBrand() async {
    Response response =
        await dio.get("https://parallelum.com.br/fipe/api/v1/carros/marcas");
    final brands = response.data as List;
    final List<BrandModel> brandList =
        brands.map((brand) => BrandModel.fromJson(brand)).toList();
    return brandList;
  }
}
