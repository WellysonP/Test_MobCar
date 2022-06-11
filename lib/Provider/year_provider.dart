import 'package:flutter/cupertino.dart';
import 'package:mobicar/Provider/brand_provider.dart';
import 'package:mobicar/Provider/vehicle_provider.dart';
import 'package:mobicar/models/brand_model.dart';
import 'package:mobicar/models/vehicle_model.dart';
import 'package:mobicar/services/vehicle_service.dart';

import '../models/year_model.dart';
import '../services/year_service.dart';

class YearProvider extends ChangeNotifier {
  final YearService _service;
  final BrandProvider brandProvider;
  final VehicleProvider vehicleProvider;

  YearProvider(this._service, this.brandProvider, this.vehicleProvider);

  List<YearModel> years = [];
  YearModel? selectedYear;

  Future<void> getYear() async {
    BrandModel? selectedBrand = brandProvider.selectedBrand;
    VehicleModel? selectedVehicle = vehicleProvider.selectedVehicle;
    years = await _service.getYear(selectedBrand!, selectedVehicle!);
    notifyListeners();
  }

  void setSelectedYear(YearModel value) {
    selectedYear = value;
    notifyListeners();
  }
}
