import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobicar/models/dummy.dart';
import 'package:provider/provider.dart';

import '../Provider/cars.dart';
import '../component/car_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<Cars>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/Group 2.png"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset("assets/images/menu-fold.png")),
        ],
      ),
      body: Column(
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
                  style: TextButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {},
                  child: Text(
                    "Add new",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
    );
  }
}
