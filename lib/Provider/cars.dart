import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobicar/models/brand_model.dart';
import 'package:mobicar/models/dummy.dart';
import 'package:mobicar/services/brand_service.dart';
import '../models/car_model.dart';

class Cars with ChangeNotifier {
  List _items = [];
  List get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> addCar(Car car) async {
    _items.add(
      Car(
        id: Random().nextDouble().toString(),
        brand: car.brand,
        vehicles: car.vehicles,
        year: car.year,
        price: car.price,
        imageUrl: car.imageUrl,
      ),
    );
    notifyListeners();
  }

  Future<void> updatCar(Car car) async {
    int index = _items.indexWhere((c) => c.id == car.id);
    if (index >= 0) {
      _items[index] = car;
    }
    notifyListeners();
  }

  Future<void> saveCar(Map<String, Object> data) {
    bool hasId = data["id"] != null;

    final car = Car(
      id: hasId ? data["id"] as String : Random().nextDouble().toString(),
      brand: data["brand"] as String,
      vehicles: data["vehicles"] as String,
      year: data["year"] as String,
      price: data["price"] as String,
      // imageUrl: data["imageUrla"] as String,
    );

    if (hasId) {
      return updatCar(car);
    } else {
      return addCar(car);
    }
  }

  void removeCar(Car car) {
    int index = _items.indexWhere((c) => c.id == car.id);

    if (index >= 0) {
      final car = _items[index];
      _items.remove(car);
      notifyListeners();
    }
  }

  // Future<List<BrandModel>> getBrand() async {
  //   // listCarBrand.clear();
  //   Response response =
  //       await dio.get("https://parallelum.com.br/fipe/api/v1/carros/marcas");
  //   // for (int i = 0; i < response.data.length; i++) {
  //   //   List itemCarBrand = [response.data[i]["nome"]];
  //   //   listCarBrand += itemCarBrand;
  //   // }
  //   final brands = response.data as List;
  //   final List<BrandModel> brandList =
  //       brands.map((brand) => BrandModel.fromJson(brand)).toList();
  //   print(brandList);
  //   return brandList;
  // }

  // Future<void> getVehicle() async {
  //   listCarVehicles.clear();
  //   Response response = await dio
  //       .get("https://parallelum.com.br/fipe/api/v1/carros/marcas/10/modelos");
  //   for (int i = 0; i < response.data.length; i++) {
  //     List itemCarVehicle = [response.data["modelos"][i]["nome"]];
  //     listCarVehicles += itemCarVehicle;
  //   }
  //   // print(listCarVehicles);
  // }

  // Future<void> getyear() async {
  //   listCarYear.clear();
  //   Response response = await dio
  //       .get("https://parallelum.com.br/fipe/api/v1/carros/marcas/10/modelos");
  //   for (int i = 0; i < response.data.length; i++) {
  //     List itemCarYear = [response.data["anos"][i]["nome"]];
  //     listCarYear += itemCarYear;
  //   }
  //   // print(_items);
  // }
}
