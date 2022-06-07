import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobicar/models/dummy.dart';

import '../models/car_models.dart';

class Cars with ChangeNotifier {
  List<Car> get _items => dummy;
  List<Car> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  // void addCar(Car car) {
  //   _items.add(
  //     Car(
  //       id: Random().nextDouble().toString(),
  //       brand: car.brand,
  //       vehicles: car.vehicles,
  //       year: car.year,
  //       price: car.price,
  //       imageUrl: car.imageUrl,
  //     ),
  //   );
  //   notifyListeners();
  // }

  // void updatCar(Car car) {
  //   int index = _items.indexWhere((c) => c.id == car.id);
  //   if (index >= 0) {
  //     _items[index] = car;
  //   }
  //   notifyListeners();
  // }

  // void saveCar(Map<String, Object> data) {
  //   bool hasId = data["id"] != null;

  //   final car = Car(
  //     id: hasId ? data["id"] as String : Random().nextDouble().toString(),
  //     brand: data["brand"] as String,
  //     vehicles: data["vehicles"] as String,
  //     year: data["year"] as int,
  //     price: data["price"] as double,
  //     imageUrl: data["imageUrl"] as String,
  //   );

  //   if (hasId) {
  //     return updatCar(car);
  //   } else {
  //     return addCar(car);
  //   }
  // }

  // void removeCar(Car car) {
  //   int index = _items.indexWhere((c) => c.id == car.id);

  //   if (index >= 0) {
  //     final car = _items[index];
  //     _items.remove(car);
  //     notifyListeners();
  //   }
  // }
}
