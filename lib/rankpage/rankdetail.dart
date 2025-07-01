import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:OzO/picker/colorpicker.dart';
import 'package:OzO/picker/zodiacpicker.dart';

class RankDetail extends StatefulWidget {

  final String ranking;
  final String name;

  const RankDetail({
    super.key,
    required this.ranking,
    required this.name
  });

  @override
  State<RankDetail> createState() => _RankDetailState();
}

class _RankDetailState extends State<RankDetail> {

  late String content = "";
  late String lucky = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContent();
  }

  Future<void> getContent() async {
    final response = await http.get(
      Uri.parse("http://localhost:8080/crawl/content-lucky?name=${widget.name}")
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      if (data.isNotEmpty) {
        final result = data[0] as Map<String, dynamic>;
        String content = result['content'] ?? "";
        String lucky = result['lucky'] ?? "";

        if (mounted) {
          setState(() {
            this.content = content;
            this.lucky = lucky;
          });
        }
      }
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 300,
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: getByColor(widget.ranking),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      widget.ranking,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10
                      ),
                    )
                  )
                ),
                SizedBox(width: 10),
                Text(
                  changeEnToKo(widget.name),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(102),
                          blurRadius: 4,
                          offset: Offset(4,4)
                        ),
                        BoxShadow(
                          color: getByColor(widget.ranking).withAlpha(102),
                          blurRadius: 4,
                          offset: Offset(-4, -4)
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        content,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      )
                    ),
                  ),

                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(102),
                          blurRadius: 4,
                          offset: Offset(4, 4)
                        ),
                        BoxShadow(
                          color: getByColor(widget.ranking).withAlpha(102),
                          blurRadius: 4,
                          offset: Offset(-4, -4)
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        lucky,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13
                        ),
                      )
                    )
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
