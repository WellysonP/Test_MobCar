import 'package:flutter/material.dart';
import 'package:mobicar/Provider/cars.dart';
import 'package:provider/provider.dart';

import '../models/car_models.dart';

class CarTile extends StatelessWidget {
  final Car car;
  const CarTile({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(car.vehicles),
    );
  }
}
