import 'package:flutter/material.dart';
import 'package:mobicar/component/new_car_dialog.dart';
import 'package:mobicar/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../Provider/cars.dart';
import '../component/car_tile.dart';
import '../component/new_car_dialog.dart';

class ListCarPage extends StatelessWidget {
  const ListCarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<Cars>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/Group 2.png"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.HOME_DETAIL);
              },
              icon: Image.asset("assets/images/menu-fold.png")),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.copyright_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "2020. All rights reserved to Mobcar.",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title 1",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Title 2",
                          style: TextStyle(fontSize: 16),
                        ),
                        Divider(thickness: 1),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          primary: Colors.white),
                      child: Text("Add new"),
                      onPressed: () {
                        newCarDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cars.itemsCount,
                  itemBuilder: (ctx, i) => Column(
                    children: [
                      CarTile(car: cars.items[i]),
                      SizedBox(height: 10),
                      Divider(thickness: 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
