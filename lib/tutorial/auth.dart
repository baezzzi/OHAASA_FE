import 'package:OzO/tutorial/nick_setting.dart';
import 'package:flutter/material.dart';
import 'package:OzO/layout/style.dart';
import 'package:OzO/main.dart';
import 'package:OzO/layout/nextbutton.dart';

import 'package:permission_handler/permission_handler.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  int pushColor = 0xFFEFE7E7;
  int galleryColor = 0xFFEFE7E7;

  String pushText = "설정";
  String galleryText = "설정";

  Color pushTextColor = Colors.black54;
  Color galleryTextColor = Colors.black54;


  // 푸시알람 권한 요청 함수
  Future<void> permissionAlarm() async {
    var status = await Permission.notification.request();
    if (status.isGranted) {
      print("푸시알람 허용 됨");
      setState(() {
        pushColor = 0xFF61ABFF;
        pushText = "완료";
        pushTextColor = Colors.white;
      });
    } else {
      print("거부됨");
    }
  }

  // 갤러리 권한 요청 함수
  Future<void> permissionGallery() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      print("갤러리 허용");
      setState(() {
        galleryColor = 0xFF61ABFF;
        galleryText = "완료";
        galleryTextColor = Colors.white;
      });
    } else {
      print("갤러리 허용 불가");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: headerDecoration,
                  ),
                  Positioned(
                    top: 80,
                    left: 15,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp()));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset(
                  "assets/images/hand.png",
                  width: 70,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox( height: 5,),
                    Text(
                      "반갑습니다!\nOzO 이용을 위한\n권한 허용이 필요합니다.",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFEFE7E7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/ledbell.png",
                              width: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "알림",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                "매일 아침 운세 제공",
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment(.3, 0),
                          child: GestureDetector(
                            onTap: () {
                              permissionAlarm();
                            },
                            child: Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color(pushColor),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text(
                                  pushText,
                                  style: TextStyle(
                                    color: pushTextColor,
                                  ),
                                ),
                              )
                            ),
                          )
                        )
                      ]
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFEFE7E7),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/camera.png",
                              width: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 60,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "갤러리",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                "프로필 사진 첨부",
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment(.3, 0),
                          child: GestureDetector(
                            onTap: () {
                              permissionGallery();
                            },
                            child: Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color(galleryColor),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text(
                                  galleryText,
                                  style: TextStyle(
                                    color: galleryTextColor,
                                  ),
                                ),
                              )
                            ),
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.05),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => NickSetting()));
                },
                child: NextButton(text: "다음")
              )
            )
          )
        ],
      )
    );
  }
}
