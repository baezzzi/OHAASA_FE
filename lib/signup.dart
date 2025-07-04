import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:OzO/layout/style.dart';
import 'package:OzO/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // TextField Controller 선언
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController pwcheckController = TextEditingController();

  // 아이디 사용 가능 여부
  String checkIdMessage = "";
  String signUpMessage = "";

  // firebase auth 요청
  Future<void> signUp() async {
    if (pwController.text == pwcheckController.text) {

      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: pwController.text.trim()
        );

        final response = await http.post(
          Uri.parse("http://localhost:8080/users/sign-up"),
          headers: {"Content-Type" : "application/json"},
          body: jsonEncode({
            "email" : emailController.text,
            "uid" : credential.user?.uid
          })
        );

        if (response.statusCode == 200) {
          await FirebaseAuth.instance.signOut();

          if (mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn()));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          setState(() {
            signUpMessage = "이미 사용 중인 이메일입니다.";
          });
          print("사요웆ㅇ");
        } else if (e.code == 'weak-password') {
          setState(() {
            signUpMessage = "비밀번호가 너무 약합니다";
          });
        } else {
          print("회원가입 실패 ${e.message}");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  // 비밀번호 같은지 확인
  String checkPwMessage = "";
  void checkPw() {
    if (pwController.text != pwcheckController.text) {
      setState(() {
        checkPwMessage = "비밀번호가 일치하지 않습니다.";
      });
    } else {
      setState(() {
        checkPwMessage = "";
      });
    }
  }

  // firebase auth token


  // 메모리 누수 방지 컨트롤러 해제
  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    pwcheckController.dispose();
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
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
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
                        SizedBox(height: 80),
                        Text(
                          "create\nyour account",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xFFD1C3FF),
                              fontSize: 22,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        SizedBox(height: 70,),
                        TextField(
                          controller: emailController,
                          decoration: buttonDecoration.copyWith(hintText: '이메일'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 14,),
                        // 비밀번호 입력
                        TextField(
                          controller: pwController,
                          decoration: buttonDecoration.copyWith(hintText: '비밀번호 (8자 이상)'),
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
                          onChanged: (value) => checkPw(),
                        ),
                        SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            checkPwMessage,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13
                            ),
                          ),
                        ),
                        // 이메일 입력
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: signUp,
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0xFFFFD4CB), Color(0xFFD1C3FF)]),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "계정 생성하기",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          )
        ),
      ),
    );
  }
}
