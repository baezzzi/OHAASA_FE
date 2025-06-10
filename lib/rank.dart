import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:scroll_date_picker/scroll_date_picker.dart';

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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 930,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 1),
                    child: Container(
                      width: double.infinity,
                      height: 800,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60)
                        )
                      ),
                      child: Column(
                        children: [
                          if(rankMap.isNotEmpty)
                            for (int i = 1; i <= 12; i++)
                              if (rankMap.containsKey(i.toString()))
                                Column(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                      ),
                                      child: Text('Rank $i: ${rankMap[i.toString()]['name']}',
                                      style: TextStyle(color: Colors.white),),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withAlpha(102),
                      blurRadius: 10,
                      offset: Offset(-4, -4)
                  )
                ]
            ),
            child: Align(
              alignment: Alignment(0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.menu_rounded, color: Colors.pinkAccent, size: 50,),
                  Icon(Icons.favorite_rounded, color: Colors.pinkAccent, size: 50,),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Rank()));
                      },
                      child: Icon(Icons.extension_rounded, color: Colors.pinkAccent, size: 50,)
                  )
                ],
              ),
            )
        ),
      )
    );
  }
}
