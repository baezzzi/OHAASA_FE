import 'package:flutter/material.dart';
import 'style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ohasa_front/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // TextField Controller 선언
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController pwcheckController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController zodiacController = TextEditingController();

  // post 요청 보내기
  Future<void> signUp() async {
    final response = await http.post(
      Uri.parse("http://localhost:8080/users/sign-up"),
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode({
        "id": idController.text,
        "pw" : pwController.text,
        "checkpw" : pwcheckController.text,
        "email" : emailController.text,
        "nickname" : nicknameController.text,
        "zodiac" : zodiacController.text,
      }),
    );

    if (response.statusCode == 200) {
      print("회원가입 성공!");
      if (mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn()));
    } else {
      print("회원가입 실패 ${response.body}");
    }
  }

  // 메모리 누수 방지 컨트롤러 해제
  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    pwcheckController.dispose();
    emailController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  // UI 부분
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // 키보드 숨기기
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Stack(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      Text(
                        "create\nyour account",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Stack(
                        children: [
                          // 아이디 입력
                          TextField(
                            controller: idController,
                            decoration: buttonDecoration.copyWith(hintText: '아이디'),
                          ),
                          Positioned(
                            top: 10,
                            right: 0,
                            child: Container(
                              width: 70,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "중복확인",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 14,),
                      // 비밀번호 입력
                      TextField(
                        controller: pwController,
                        decoration: buttonDecoration.copyWith(hintText: '비밀번호'),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 14,),
                      // 비밀번호 확인
                      TextField(
                        controller: pwcheckController,
                        decoration: buttonDecoration.copyWith(hintText: '비밀번호 확인'),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 14,),
                      // 이메일 입력
                      TextField(
                        controller: emailController,
                        decoration: buttonDecoration.copyWith(hintText: '이메일'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 14,),
                      TextField(
                        controller: nicknameController,
                        decoration: buttonDecoration.copyWith(hintText: '닉네임'),
                      ),
                      TextField(
                        controller: zodiacController,
                        decoration: buttonDecoration.copyWith(hintText: '별자리'),
                      ),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: signUp,
                  child: Center(
                    child: Container(
                      width: 330,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                          "계정 생성하기",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
