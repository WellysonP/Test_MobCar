import 'package:flutter/material.dart';
import 'package:mobicar/Provider/cars.dart';
import 'package:mobicar/component/new_car_form.dart';
import 'package:provider/provider.dart';

Future<dynamic> newCarDialog(BuildContext context) {
  int i = 0;
  List brand = [];
  final cars = Provider.of<Cars>(context, listen: false);
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      content: SizedBox(
        width: 342,
        height: 437,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.directions_car, size: 24),
                    SizedBox(width: 10),
                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                )
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 310,
                height: 120,
                child: Image.asset(
                  "assets/images/Home mobile.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            NewCarForm(),
            SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                  onPressed: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(),
                    ),
                    width: 73,
                    height: 36,
                    child: Center(
                      child: Text(
                        "Cancelar",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                  onPressed: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 59,
                      height: 36,
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          "Salvar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
