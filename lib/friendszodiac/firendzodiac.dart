import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:OzO/picker/zodiacpicker.dart';
import 'package:OzO/picker/colorpicker.dart';

class FriendZodiac extends StatefulWidget {

  final String name;
  final String zodiac;
  final String en;
  final String ranking;

  const FriendZodiac({
    super.key,
    required this.name,
    required this.zodiac,
    required this.en,
    required this.ranking
  });

  @override
  State<FriendZodiac> createState() => _FriendZodiacState();
}

class _FriendZodiacState extends State<FriendZodiac> {

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
      Uri.parse("http://localhost:8080/crawl/content-lucky?name=${widget.en}")
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      print(widget.en);
      print(data);
      if (data.isNotEmpty) {
        final result = data[0] as Map<String, dynamic>;
        lucky = result["lucky"] ?? "";
        content = result["content"] ?? "";
      }
      if (mounted) {
        setState(() {
          content = content;
          lucky = lucky;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 70,
                    height: 20,
                    decoration: BoxDecoration(
                      color: getByColor(widget.ranking),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        changeEnToKo(widget.zodiac),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Container(
                width: 270,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: getByColor(widget.ranking).withAlpha(102),
                      blurRadius: 4,
                      offset: Offset(-4, -4)
                    ),
                    BoxShadow(
                      color: Colors.grey.withAlpha(102),
                      blurRadius: 4,
                      offset: Offset(4, 4)
                    )
                  ]
                ),
                child: Center(
                  child: Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: getByColor(widget.ranking).withAlpha(102),
                      blurRadius: 4,
                      offset: Offset(-4, -4)
                    ),
                    BoxShadow(
                      color: Colors.grey.withAlpha(102),
                      blurRadius: 4,
                      offset: Offset(4, 4)
                    )
                  ]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.stars_rounded, color: getByColor(widget.ranking), size: 14),
                      SizedBox(width: 5,),
                      Text(
                        lucky,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
