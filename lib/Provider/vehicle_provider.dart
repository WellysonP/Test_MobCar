import 'package:flutter/cupertino.dart';
import 'package:mobicar/Provider/brand_provider.dart';
import 'package:mobicar/models/brand_model.dart';
import 'package:mobicar/models/vehicle_model.dart';
import 'package:mobicar/services/vehicle_service.dart';

class VehicleProvider extends ChangeNotifier {
  final VehicleService _service;
  final BrandProvider brandProvider;

  VehicleProvider(this._service, this.brandProvider);

  List<VehicleModel> vehicles = [];
  VehicleModel? selectedVehicle;

  Future<void> getVehicle() async {
    BrandModel? selected = brandProvider.selectedBrand;
    vehicles = await _service.getVehicle(selected!);
    notifyListeners();
  }

  void setSelectedVehicle(VehicleModel value) {
    selectedVehicle = value;
    notifyListeners();
  }
}
