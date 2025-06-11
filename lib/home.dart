import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:OzO/bottommenu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  // 날짜 표시 작업
  // late String formattedDate = "";
  //
  // @override
  // void initState() {
  //   super.initState();
  //   DateTime now = DateTime.now();
  //   initializeDateFormatting();
  //   formattedDate = DateFormat("M월 d일 EEEE", 'ko').format(now);
  //   print(formattedDate);
  // }

  // 이미지 변수 생성
  File? _imageFile;

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

  // 순위에 따른 색 선택
  final List<Color> colors = [
    Color(0xFFFA8B8B), // 1등
    Color(0xFFFFA069), // 2-4등
    Color(0xFFB7FF9A), // 5-8등
    Color(0xFF9AB7FF), // 9-11등
    Color(0xFFCD9AFF), // 12등
  ];

  int colorIndex = 0;

  Color getByColor(int ranking) {
    switch (ranking) {
      case 1 : return colors[0];
      case 2:
      case 3:
      case 4:
        return colors[1];
      case 5:
      case 6:
      case 7:
        return colors[2];
      case 8:
      case 9:
      case 10:
      case 11:
        return colors[3];
      case 12:
        return colors[4];
      default:
        return Colors.orange;
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
                        "닉네임",
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
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          // 별자리
                          child: Text(
                            "쌍둥이자리",
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
                                          height: 180,
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
                                                color: Color(0xFFFF8282).withAlpha(102),
                                                blurRadius: 8,
                                                offset: Offset(-4,-4)
                                              )
                                            ]
                                          ),

                                          child: Center(
                                              child: Text(
                                                """동료에게 도움을 받을 예감\n가끔은 호의를 베풀어도 괜찮아""",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black54
                                                ),
                                              )
                                          ),
                                        ),
                                      ]
                                    )
                                  )
                                ),
                                SizedBox(height: 30),
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
                                                color: Color(0xFFFF8282).withAlpha(102),
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
                                                "동서남북 일곱색깔 무지개 바닐라똥",
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
