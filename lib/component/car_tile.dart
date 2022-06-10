import 'package:flutter/material.dart';
import 'package:mobicar/Provider/cars.dart';
import 'package:mobicar/component/view_dialog.dart';
import 'package:mobicar/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../models/car_model.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
                InkWell(
                  onTap: () {
                    viewDialog(context, _textTheme, car);
                  },
                  child: Text(
                    "View More",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 10,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text("View"),
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
              Navigator.of(context).pushNamed(
                AppRoutes.FORM,
                arguments: cars,
              );
            }
            if (selectedValue == FilterOptions.view) {
              viewDialog(context, _textTheme, car);
            }
          },
        ),
      ],
    );
  }
}
