import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobicar/Provider/cars.dart';
import 'package:mobicar/pages/home_detail_page.dart';
import 'package:mobicar/pages/list_car_page.dart';
import 'package:mobicar/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'component/car_tile.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Cars(),
        ),
      ],
      child: MaterialApp(
        theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
          primary: Colors.black,
          secondary: Color.fromRGBO(0, 173, 238, 1),
        )),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (context) => ListCarPage(),
          AppRoutes.HOME_DETAIL: (context) => HomedetailPage(),
        },
      ),
    );
  }
}
