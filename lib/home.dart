import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  // // 날짜 표시 작업
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

  // 닉네임 받아오는 거 할건데 fcm 구현한다음에 하는게 나을듯
  // Future<void> getNickname() async {
  //   final response = await http.get(
  //     Uri.parse("http://localhost:8080/users/find-nickname?id=${}"),
  //     headers: {"Content-Type" : "application/json"},
  //   );
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
    // 높이
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
                Icon(Icons.extension_rounded, color: Colors.pinkAccent, size: 50,)
              ],
            ),
          )
        ),
      )
    );
  }
}
