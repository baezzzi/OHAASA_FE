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
                        SizedBox(height: 25,),
                        Text(
                          "5월 29일 목요일",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20
                          ),
                        ),
                        SizedBox(height: 35),

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
                                    borderRadius: BorderRadius.circular(40),
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 30,),
                                        SizedBox(height: 70,),
                                        Container(
                                          width: 30,
                                          height: 30,
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
                                        SizedBox(width: 50,),
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
                                          fontSize: 18
                                        ),
                                      )
                                    )
                                  ]
                                )
                              ]
                            )
                          )
                        ),

                        SizedBox(height: 50,),
                        Center(
                          child: SizedBox(
                            width: 300,
                            height: 100,
                            child: Stack(
                              children: [
                                Container(
                                  width: 300,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
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


              ],
            ),
          ),
        ),
      ),
    );
  }
}
