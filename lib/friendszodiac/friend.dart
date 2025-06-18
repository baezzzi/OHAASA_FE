import 'package:flutter/material.dart';

import 'package:OzO/layout/bottommenu.dart';
import 'package:OzO/sidemenu/sidepopup.dart';

class Friend extends StatefulWidget {
  const Friend({super.key});

  @override
  State<Friend> createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePopup(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.black54, Colors.blueGrey])
            ),
          ),

          Text("data"),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding : EdgeInsets.only(bottom: 20),
              child: BottomMenu(),
            ),
          )
        ],
      ),
    );
  }
}
