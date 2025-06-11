import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:OzO/bottommenu.dart';

class Rank extends StatefulWidget {
  const Rank({super.key});

  @override
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getZodiac();
  }
  Map<String, dynamic> rankMap = {};

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
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            color: Colors.orange,
          ),
          Column(
            children: [

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
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${rankMap[i.toString()]['name']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
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
              padding: EdgeInsets.only(bottom: 30),
              child: BottomMenu(),
            ),
          ),
        ],
      ),
    );
  }
}
