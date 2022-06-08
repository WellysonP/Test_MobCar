import 'package:flutter/material.dart';

import '../utils/app_routes.dart';

class HomedetailPage extends StatelessWidget {
  const HomedetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
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
          Image.asset(
            "assets/images/Home mobile.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
            top: 80,
            right: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Homepage",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Menu item 2",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Menu item 3",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Menu item 4",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Menu item 5",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Menu item 6",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
