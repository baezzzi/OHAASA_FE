import 'dart:convert';

import 'package:OzO/picker/colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:OzO/layout/bottommenu.dart';
import 'package:OzO/sidemenu/sidepopup.dart';
import 'package:OzO/friendszodiac/addmodal.dart';
import 'package:OzO/friendszodiac/content.dart';
import 'package:OzO/friendszodiac/firendzodiac.dart';
import 'package:OzO/picker/zodiacpicker.dart';

class Friend extends StatefulWidget {
  const Friend({super.key});

  @override
  State<Friend> createState() => _FriendState();
}

class _FriendState extends State<Friend> {

  final user = FirebaseAuth.instance.currentUser;

  late String ranking = "";
  late String date = "";
  Map<String, dynamic> friendMap = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting("ko", "");
    DateTime now = DateTime.now();
    date = DateFormat("M월 d일 EEEE", "ko").format(now);
    _showFrList();
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

  Future<void> _showZodiac(String name, String zodiac, String ranking) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: FriendZodiac(
            name: name,
            zodiac: zodiac,
            en : zodiac,
            ranking : ranking
          ),
        );
      }
    );
  }

  // 칭긔들 출력
  Future<void> _showFrList() async {
    final userEmail = user?.email;
    final response = await http.get(
      Uri.parse("http://localhost:8080/friend/find-friend?email=$userEmail")
    );

    if (response.statusCode == 200) {
      print("통신 성공");
      print(response.body);
      List<dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> tempMap = {};

      for (var item in data) {
        String id = item["id"];
        tempMap[id] = item;
      }

      setState(() {
        friendMap = tempMap;
        build(context);
      });
    } else {
      print(response.body);
    }
  }

  // 칭긔 손절
  Future<void> deleteFriend(String id) async {
    final userEmail = user?.email;
    final response = await http.post(
      Uri.parse("http://localhost:8080/friend/delete-friend"),
      headers: { "Content-Type" : "application/json" },
      body: jsonEncode({
        "email" : userEmail,
        "id" : id,
      })
    );

    if (response.statusCode == 200) {
      print("친구 삭제 완");
      setState(() {
        build(context);
      });
    }
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: 900,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              if (friendMap.isNotEmpty)
                                for (var i in friendMap.keys)
                                  if (friendMap.containsKey(i.toString()))
                                    Column(
                                      children: [
                                        Slidable(
                                          key: Key(friendMap[i.toString()]["id"].toString()),
                                          endActionPane: ActionPane(
                                            motion: DrawerMotion(),
                                            children: [

                                              SlidableAction(
                                                onPressed: (context) {
                                                  setState(() {
                                                    deleteFriend(friendMap[i.toString()]["id"]);
                                                    friendMap.remove(i.toString());
                                                    // if(mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                                                  });
                                                },
                                                backgroundColor: Colors.black54,
                                                icon: Icons.delete,
                                              ),
                                              SlidableAction(
                                                onPressed: (context) {
                                                  setState(() {
                                                    if(mounted) Navigator.pop(context);
                                                  });
                                                },
                                                backgroundColor: Colors.blueGrey,
                                                icon: Icons.edit,

                                              ),
                                            ]
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              _showZodiac(
                                                friendMap[i.toString()]["name"],
                                                friendMap[i.toString()]["zodiac"],
                                                friendMap[i.toString()]["ranking"]
                                              );
                                            },
                                            child: Content(
                                              name : friendMap[i.toString()]["name"],
                                              zodiac: changeEnToKo(friendMap[i.toString()]["zodiac"]),
                                              color: getByColor(friendMap[i.toString()]["ranking"] ?? "")
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20)
                                      ],
                                    ),

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
                  )
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
