import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:OzO/layout/bottommenu.dart';
import 'package:OzO/picker/zodiacpicker.dart';
import 'package:OzO/sidemenu/sidepopup.dart';

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
  File? _imageFile;
  int colorIndex = 0;

  // 페이지 첫 렌딩
  @override
  void initState() {
    super.initState();
    getNickname();
    getZodiac();
  }

  // 닉네임 가져오기
  Future<void> getNickname() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final response = await http.get(
      Uri.parse("http://localhost:8080/users/find-nickname?email=$userEmail"),
      headers: {"Cotent-Type" : "application/json"}
    );

    if (response.statusCode == 200) {
      setState(() {
        nickname = response.body;
        print(nickname);
      });
    }
  }

  // 별자리 가져오기
  Future<void> getZodiac() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final response = await http.get(
      Uri.parse("http://localhost:8080/users/find-zodiac?email=$userEmail"),
      headers: { "Content-Type" : "application/json"}
    );
    if (response.statusCode == 200) {
      final String num = response.body;
      if (mounted) {
        setState(() {
          zodiacName = getNameByNum(num);
          zodiacEnName = getEnName(num);
          print(zodiacName);
          print(zodiacEnName);
        });
      }
      getContentLucky();
    }
  }
  
  // 별자리 내용 and ranking 가져오기
  Future<void> getContentLucky() async {
    final response = await http.get(
      Uri.parse("http://localhost:8080/crawl/content-lucky?name=$zodiacEnName"),
      headers: { "Content-Type" : "application/json" }
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

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // 순위에 따른 색
  final List<Color> colors = [
    Color(0xFFFA8B8B), // 1등
    Color(0xFFFFA069), // 2-4등
    Color(0xFF9AD389), // 5-8등
    Color(0xFF8CA8EA), // 9-11등
    Color(0xFF313857), // 12등

  ];

  Color getByColor(String ranking) {
    switch (ranking) {
      case "1" : return colors[0];
      case "2":
      case "3":
      case "4":
        return colors[1];
      case "5":
      case "6":
      case "7":
        return colors[2];
      case "8":
      case "9":
      case "10":
      case "11":
        return colors[3];
      case "12":
        return colors[4];
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePopup(), // 또는 Drawer 위젯
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            color: getByColor(ranking),
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
                      SizedBox(height: 100,),
                      // 닉네임
                      Text(
                        nickname,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          color: getByColor(ranking),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          // 별자리
                          child: Text(
                            zodiacName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Expanded(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: 1000,
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                // 별자리 운세 내용
                                Center(
                                  child: SizedBox(
                                    width: 300,
                                    height: 180,
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
                                SizedBox(height: 15),
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 20,),
                                            Icon(Icons.stars_rounded, color: Color(0xFFFF8282),),
                                            SizedBox(width: 15,),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 8,
                        color: Colors.white,
                      ),
                      image: _imageFile != null
                          ? DecorationImage(
                        image: FileImage(_imageFile!),
                        fit: BoxFit.cover,
                      ) : null,
                    ),
                    child: _imageFile == null
                        ? const Icon(Icons.face, color: Colors.white, size: 100,)
                        : null,
                  ),
                )
              ],
            )
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding : EdgeInsets.only(bottom: 30),
              child: BottomMenu(),
            ),
          )
        ],
      )
    );
  }
}
