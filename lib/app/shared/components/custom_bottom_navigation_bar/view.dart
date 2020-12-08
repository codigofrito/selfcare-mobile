import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class CustomBottomNavigationBar
    extends GetView<CustomBottomNavigationBarController> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "bottom",
      child: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          onTap: null,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'perfil',
            ),
          ],
        ),
      ),
    );

    // return StyleProvider(
    //   style: Style(),
    //   child: ConvexAppBar(

    //     height: 50,
    //     curveSize: 80,
    //     style: TabStyle.fixedCircle,
    //     backgroundColor: Colors.white,
    //     color: Colors.grey,
    //     activeColor: Theme.of(context).primaryColor,

    //     items: [
    //       TabItem(icon: Icons.home),
    //       TabItem(icon: Icons.person),
    //       TabItem(icon: Icons.work),
    //       TabItem(icon: Icons.people),
    //       TabItem(icon: Icons.message),
    //     ],
    //     initialActiveIndex: 1, //optional, default as 0
    //     onTap: (int i) => null,
    //   ),
    // );
  }
}
