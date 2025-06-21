import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:OzO/layout/bottommenu.dart';
import 'package:OzO/sidemenu/sidepopup.dart';
import 'package:OzO/friendszodiac/addmodal.dart';
import 'package:OzO/friendszodiac/content.dart';
import 'package:OzO/friendszodiac/firendzodiac.dart';

class Friend extends StatefulWidget {
  const Friend({super.key});

  @override
  State<Friend> createState() => _FriendState();
}

class _FriendState extends State<Friend> {

  late String date = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting("ko", "");
    DateTime now = DateTime.now();
    date = DateFormat("M월 d일 EEEE", "ko").format(now);
  }

  Future<void> _showAddFriend() async{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: AddModal(),
        );
      }
    );
  }

  Future<void> _showZodiac() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: FriendZodiac(),
        );
      }
    );
  }

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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.interests_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(height: 5),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "친구들 별자리 운세",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)
                    )
                  ),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 900,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            Text("date"),
                            Content(),
                            SizedBox(height: 40),
                            GestureDetector(
                              onTap: () => _showZodiac(),
                              child: Content(),
                            ),
                            SizedBox(height: 40),
                            // 칭긔 추가
                            GestureDetector(
                              onTap: () => _showAddFriend(),
                              child: Container(
                                width: double.infinity,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
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
