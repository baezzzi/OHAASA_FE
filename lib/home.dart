import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
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
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),

                    child: Column(
                      children: [
                        SizedBox(height: 90,),

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
                        SizedBox(height: 40,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios_new, color: Colors.black54,),
                            SizedBox(width: 10,),
                            Text(
                              "5월 29일 목요일",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 25
                              ),
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.arrow_forward_ios, color: Colors.black54,)
                          ],
                        ),

                        SizedBox(height: 50,),
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
                                ),

                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // SizedBox(width: 30,),
                                        SizedBox(height: 70,),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFF8282),
                                            borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: Center(
                                            child: Text(
                                              "1",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          )
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "쌍둥이자리",
                                          style: TextStyle(
                                            color: Color(0xFFFF8282),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        """동료에게 도움을 받을 예감\n가끔은 호의를 베풀어도 괜찮아""",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black54
                                        ),
                                      )
                                    )
                                  ]
                                )
                              ]
                            )
                          )
                        ),

                        SizedBox(height: 30,),
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
                        )
                      ],
                    ),
                  ),
                ),

                // 프로필 사진
                Align(
                  alignment: Alignment(0, -.8),
                  child: GestureDetector(
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
                ),

                // 하단 메뉴바

              ],
            ),
          ),
        ),
      ),
    );
  }
}
