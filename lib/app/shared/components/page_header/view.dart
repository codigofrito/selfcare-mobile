import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class PageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    
    //Hero(
     // tag: "pageHeader",
    //  child: 
      Container(
        height: 150,
        decoration: BoxDecoration(
          color: TinyColor(Theme.of(context).primaryColor).brighten(5).color,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
 //     ),
    );
  }
}
