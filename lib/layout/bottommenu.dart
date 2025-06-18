import 'package:flutter/material.dart';

import 'package:OzO/rank.dart';
import 'package:OzO/home.dart';
import 'package:OzO/friendszodiac/friend.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(0,-4)
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Builder(
            builder: (BuildContext scaffoldContext) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(scaffoldContext).openDrawer();
                },
                child: Icon(Icons.menu_rounded, color: Colors.black54),
              );
            },
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Home())),
            child: Icon(Icons.favorite_rounded, color: Colors.black54,),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Friend())),
            child: Icon(Icons.diversity_1_rounded, color: Colors.black54,),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Rank())),
            child: Icon(Icons.extension_rounded, color: Colors.black54,),
          )
        ],
      ),
    );
  }
}
