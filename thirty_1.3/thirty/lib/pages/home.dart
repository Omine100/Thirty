import 'package:flutter/material.dart';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //CLASS INITIALIZATION
  CloudFirestore cloudFirestore = new CloudFirestore();
  RouteNavigation routeNavigation = new RouteNavigation();

  //USER INTERFACE: Home screen
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () {
            cloudFirestore.signOut();
            cloudFirestore.getSignedInStatus().then((status) {
              routeNavigation.navigateLogin(context, status);
            });
          },
          child: Text(
            "Home",
            style: TextStyle(
              color: Colors.red,
              fontSize: 100,
            ),
          ),
        ),
      ),
    );
  }
}
