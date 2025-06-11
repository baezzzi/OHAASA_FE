import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:OzO/style.dart';
import 'package:OzO/nextbutton.dart';
import 'package:OzO/zodiac_setting.dart';

class NickSetting extends StatefulWidget {
  const NickSetting({super.key});

  @override
  State<NickSetting> createState() => _NickSettingState();
}

class _NickSettingState extends State<NickSetting> {

  TextEditingController nicknameController = TextEditingController();

  Future<void> saveNickname() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final response = await http.post(
      Uri.parse("http://localhost:8080/users/save-nickname"),
      headers: { "Content-Type" : "application/json" },
      body: jsonEncode({
        "email" : userEmail,
        "nickname" : nicknameController.text.trim()
      })
    );

    if (response.statusCode == 200) {
      print("닉네임 저장완");
      if (mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => ZodiacSetting()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
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
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 70,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Image.asset(
                    "assets/images/sparkle.png",
                    width: 70,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8,),
                      Text(
                        "OzO 이용을 위한\n닉네임을 입력하세요!",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 60,),
                      TextField(
                        controller: nicknameController,
                        decoration: buttonDecoration.copyWith(hintText: "닉네임")
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
                  onTap: saveNickname,
                  child: NextButton(text: "다음")
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
