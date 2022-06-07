import 'package:flutter/material.dart';
import 'package:mobicar/Provider/cars.dart';
import '../models/car_models.dart';

class CarTile extends StatelessWidget {
  final Car car;
  const CarTile({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            width: 48,
            height: 48,
            decoration: BoxDecoration(),
            child: Image.network(
              car.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                car.vehicles,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                car.year.toString(),
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                "View More",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
