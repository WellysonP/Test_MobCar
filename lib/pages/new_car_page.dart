import 'package:flutter/material.dart';

Future<dynamic> newCarPage(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.directions_car),
                  SizedBox(width: 10),
                  Text("Title"),
                ],
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ],
      ),
      actions: [],
    ),
  );
}
