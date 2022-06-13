import 'package:flutter/cupertino.dart';
import 'package:mobicar/Provider/brand_provider.dart';
import 'package:mobicar/Provider/vehicle_provider.dart';
import 'package:mobicar/Provider/year_provider.dart';
import 'package:mobicar/models/brand_model.dart';
import 'package:mobicar/models/car_data_model.dart';
import 'package:mobicar/models/vehicle_model.dart';
import 'package:mobicar/services/price_service.dart';
import '../models/year_model.dart';

class PriceProvider extends ChangeNotifier {
  final PriceService _service;
  final BrandProvider brandProvider;
  final VehicleProvider vehicleProvider;
  final YearProvider yearProvider;

  PriceProvider(
    this._service,
    this.brandProvider,
    this.vehicleProvider,
    this.yearProvider,
  );

  List<CarDataModel> prices = [];
  CarDataModel? selectedPrice;

  Future<void> getPrice() async {
    BrandModel? selectedBrand = brandProvider.selectedBrand;
    VehicleModel? selectedVehicle = vehicleProvider.selectedVehicle;
    YearModel? selectedYear = yearProvider.selectedYear;
    prices = await _service.getCarData(
        selectedBrand!, selectedVehicle!, selectedYear!);
    notifyListeners();
  }

  void setSelectedPrice(CarDataModel value) {
    selectedPrice = value;
    notifyListeners();
  }
}
