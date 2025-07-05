import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:OzO/layout/bottommenu.dart';
import 'package:OzO/picker/zodiacpicker.dart';
import 'package:OzO/sidemenu/sidepopup.dart';
import 'package:OzO/picker/colorpicker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String nickname = "";
  late String zodiacName = "";
  late String zodiacEnName = "";
  late String content = "";
  late String lucky = "";
  late String ranking = "";
  late String day = "";
  late String ready = "";

  final user = FirebaseAuth.instance.currentUser;


  // 페이지 첫 렌딩
  @override
  void initState() {
    super.initState();
    showInfo();

    initializeDateFormatting("ko", "");
    DateTime now = DateTime.now();
    day = DateFormat("M / d (EE)", "ko").format(now);

    if (now.hour >= 0 && now.hour < 7) {
      setState(() {
        content = "쿨쿨 zZ";
        lucky = "별나라 여행하기";
        ranking = "★";
      });
    }
  }

  Future<void> showInfo() async {
    await getZodiac();
    await getNickname();
    getContentLucky();
  }

  // 닉네임 가져오기
  Future<void> getNickname() async {
    final userEmail = user?.email;
    final response = await http.get(
      Uri.parse("http://localhost:8080/users/find-nickname?email=$userEmail"),
    );

    if (response.statusCode == 200) {
      setState(() {
        nickname = response.body;
      });
    }
  }

  // 별자리 가져오기
  Future<void> getZodiac() async {
    final userEmail = user?.email;
    final response = await http.get(
      Uri.parse("http://localhost:8080/users/find-zodiac?email=$userEmail"),
    );
    if (response.statusCode == 200) {
      final String num = response.body;
      if (mounted) {
        setState(() {
          zodiacName = getNameByNum(num);
          zodiacEnName = getEnName(num);
        });
      }
    }
  }
  
  // 별자리 내용 and ranking 가져오기
  Future<void> getContentLucky() async {
    final response = await http.get(
      Uri.parse("http://localhost:8080/crawl/content-lucky?name=$zodiacEnName"),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      if (data.isNotEmpty) {
        final result = data[0] as Map<String, dynamic>;
        String lucky = result['lucky'] ?? '';
        String content = result['content'] ?? '';
        String ranking = result['rank'] ?? '';
        if (mounted) {
          setState(() {
            this.lucky = lucky;
            this.content = content;
            this.ranking = ranking;
          });
        }
      }
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePopup(),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: getByColor(ranking),
              ),
              Image.asset("assets/images/header.png"),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Text(
                    day,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),
                  )
                )
              )
            ],
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 900,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30,),

                      SizedBox(height: 15),
                      // 닉네임
                      Text(
                        nickname,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          color: getByColor(ranking),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(width: 15),
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(
                                child: Text(
                                  ranking,
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                )
                              )
                            ),
                            Container(
                              width: 5,
                              height: 20,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.white,
                                    width: 1
                                  )
                                )
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              height: 30,
                              child: Center(
                                child: Text(
                                  zodiacName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              )
                            )
                          ]
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: 400,
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                // 별자리 운세 내용
                                Center(
                                  child: SizedBox(
                                    width: 300,
                                    height: 150,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 300,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withAlpha(102),
                                                blurRadius: 8,
                                                offset: Offset(4,4),
                                              ),
                                              BoxShadow(
                                                color: getByColor(ranking).withAlpha(102),
                                                blurRadius: 8,
                                                offset: Offset(-4,-4)
                                              )
                                            ]
                                          ),

                                          child: Center(
                                            child: Text(
                                              content,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54
                                              ),
                                            )
                                          ),
                                        ),
                                      ]
                                    )
                                  )
                                ),
                                SizedBox(height: 20),
                                // 행운 행동
                                Center(
                                  child: SizedBox(
                                    width: 300,
                                    height: 60,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 300,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: getByColor(ranking).withAlpha(102),
                                                blurRadius: 8,
                                                offset: Offset(-4, -4)
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.withAlpha(102),
                                                blurRadius: 8,
                                                offset: Offset(4, 4)
                                              )
                                            ]
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.stars_rounded, color: getByColor(ranking)),
                                              SizedBox(width: 20),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  lucky,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        )
                                      ],
                                    )
                                  ),
                                ),

                              ],
                            ),
                          )
                        )
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),

          // 프로필 사진
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              ],
            )
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding : EdgeInsets.only(bottom: 20),
              child: BottomMenu(currentPage: "home"),
            ),
          )
        ],
      )
    );
  }
}

