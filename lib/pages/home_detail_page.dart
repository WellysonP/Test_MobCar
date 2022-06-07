import 'package:flutter/material.dart';

import '../utils/app_routes.dart';

class HomedetailPage extends StatelessWidget {
  const HomedetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Image.asset("assets/images/Group 2.png"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
              },
              icon: Image.asset("assets/images/menu-fold.png")),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/Home mobile.png",
            fit: BoxFit.cover,
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
