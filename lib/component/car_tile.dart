import 'package:flutter/material.dart';
import 'package:mobicar/Provider/cars.dart';
import 'package:mobicar/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../models/car_models.dart';

enum FilterOptions {
  view,
  edit,
  delete,
}

class CarTile extends StatelessWidget {
  final Car car;
  const CarTile({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = TextStyle(fontSize: 14);
    final cars = Provider.of<Cars>(context);
    return SingleChildScrollView(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.5), //mudar posição p/ relativa
            width: 48,
            height: 48,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                car.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
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
          ),
          SizedBox(
            width: 215, // Modificar posição
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("View"),
                // onTap: () => cars.newMethod2(context, car),
                value: FilterOptions.view,
              ),
              PopupMenuItem(
                child: Text("Edit"),
                value: FilterOptions.edit,
              ),
              PopupMenuItem(
                child: Text("Delete"),
                value: FilterOptions.delete,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.delete) {
                cars.removeCar(car);
              }
              if (selectedValue == FilterOptions.edit) {
                return;
              }
              if (selectedValue == FilterOptions.view) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.directions_car),
                            SizedBox(width: 10),
                            Text(car.vehicles),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    content: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 120,
                        width: 310,
                        child: Image.network(
                          car.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    actions: [
                      Column(
                        // modificar esse grid
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(car.brand, style: _textTheme),
                              Text(car.year.toString(), style: _textTheme),
                              SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(car.vehicles, style: _textTheme),
                              Text(car.price.toString(), style: _textTheme),
                              SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                primary: Colors.white),
                            onPressed: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                  height: 36,
                                  width: 310,
                                  child: Center(child: Text("Reservar"))),
                            ),
                          )
                          // InkWell(
                          //   onTap: () {},
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(8),
                          //     child: Container(
                          //       color: Colors.black,
                          //       width: 310,
                          //       height: 36,
                          //       child: Center(
                          //         child: Text(
                          //           "Reservar",
                          //           style: TextStyle(color: Colors.white),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
