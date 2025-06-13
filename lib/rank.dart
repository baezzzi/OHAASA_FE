import 'dart:convert';
import 'package:OzO/picker/colorpicker.dart';
import 'package:OzO/sidemenu/sidepopup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:OzO/layout/bottommenu.dart';
import 'package:OzO/picker/zodiacpicker.dart';

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
    getZodiac();
  }

  Future<void> getZodiac() async {
    final response = await http.get(
        Uri.parse("http://localhost:8080/crawl/horoscope/ranking"),
        headers: { "Content-Type" : "application/json"}
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePopup(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            color: Colors.orange,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "✨",
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    "별자리 운세 순위",
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
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
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 880,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            if (rankMap.isNotEmpty)
                              for (int i = 1; i <= 12; i++)
                                if (rankMap.containsKey(i.toString()))
                                  Column(
                                    children: [
                                      Container(
                                        width: 300,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: getByColor("$i"),
                                              blurRadius: 5,
                                              offset: Offset(0,0)
                                            )
                                          ]
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    width: 30,
                                                    child: Text(
                                                      "$i",
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      changeEnToKo(rankMap[i.toString()]['name']),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: getByColor("$i"),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight: Radius.circular(20)
                                                )
                                              ),
                                            )
                                          ]
                                        ),
                                      ),
                                      SizedBox(height: 20),
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
              child: BottomMenu(),
            ),
          ),
        ],
      ),
    );
  }

}
