import 'package:flutter/cupertino.dart';
import 'package:mobicar/models/brand_model.dart';
import 'package:mobicar/models/vehicle_model.dart';
import 'package:mobicar/services/vehicle_service.dart';

class VehicleProvider extends ChangeNotifier {
  final VehicleService _service;

  VehicleProvider(this._service);

  List<VehicleModel> vehicles = [];
  VehicleModel? selectedVehicle;
  BrandModel? brand;

  Future<void> getVehicle() async {
    vehicles = await _service.getVehicle(brand!);
    notifyListeners();
  }

  void setSelectedVehicle(VehicleModel value) {
    selectedVehicle = value;
    notifyListeners();
  }
}
