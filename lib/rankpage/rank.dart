import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:OzO/layout/bottommenu.dart';
import 'package:OzO/picker/zodiacpicker.dart';
import 'package:OzO/rankpage/rankbox.dart';
import 'package:OzO/sidemenu/sidepopup.dart';
import 'package:OzO/rankpage/rankdetail.dart';
import 'package:OzO/rankpage/ready.dart';

class Rank extends StatefulWidget {
  const Rank({super.key});

  @override
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {

  late String date = "";
  Map<String, dynamic> rankMap = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting("ko", "");
    DateTime now = DateTime.now();
    date = DateFormat('M월 d일 EEEE', 'ko').format(now);
    String day = DateFormat("EE", "ko").format(now);

    if ((day == "토") || (day == "일")) {
      print("주말");
    } else {
      print("평일");
      getZodiac();
    }
  }

  Future<void> getZodiac() async {
    final response = await http.get(
        Uri.parse("http://localhost:8080/crawl/horoscope/ranking"),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> tempMap = {};

      for (var item in data) {
        String rank = item['rank'];
        tempMap[rank] = item;
      }

      setState(() {
        rankMap = tempMap; // 상태 업데이트
      });
    }
  }

  Future<void> openDetail(String ranking, String name) async {
    showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.center,
          child: RankDetail(
            ranking: ranking,
            name: name,
          )
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
              gradient: LinearGradient(colors: [Color(0xFFD1C3FF), Color(0xFFFFD4CB)])
            )
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(height:5),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  Text(
                    "별자리 운세 순위",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
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
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 800,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            if (rankMap.isEmpty)
                              Column(
                                children: [
                                  SizedBox(height: 100),
                                  Ready()
                                ],
                              ),
                            if (rankMap.isNotEmpty)
                              for (int i = 1; i <= 12; i++)
                                if (rankMap.containsKey(i.toString()))
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          openDetail(
                                            i.toString(),
                                            rankMap[i.toString()]['name']
                                          );
                                        },
                                        child: RankBox(
                                          ranking : "$i",
                                          name : changeEnToKo(rankMap[i.toString()]["name"])
                                        ),
                                      ),
                                      SizedBox(height: 14),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    )
                  )
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: BottomMenu(currentPage: "rank",),
            ),
          ),
        ],
      ),
    );
  }

}
