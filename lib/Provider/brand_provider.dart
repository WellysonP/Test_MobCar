import 'package:flutter/cupertino.dart';
import 'package:mobicar/models/brand_model.dart';
import 'package:mobicar/services/brand_service.dart';

class BrandProvider extends ChangeNotifier {
  final BrandService _service;

  BrandProvider(this._service);

  List<BrandModel> brands = [];
  BrandModel? selectedBrand;

  Future<void> getBrand() async {
    brands = await _service.getBrand();
    notifyListeners();
  }

  void setSelectedBrand(BrandModel value) {
    selectedBrand = value;
    notifyListeners();
  }
}
