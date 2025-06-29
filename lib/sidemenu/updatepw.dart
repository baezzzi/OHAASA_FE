import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:OzO/layout/style.dart';
import 'package:OzO/home.dart';

class UpdatePw extends StatefulWidget {
  const UpdatePw({super.key});

  @override
  State<UpdatePw> createState() => _UpdatePwState();
}

class _UpdatePwState extends State<UpdatePw> {

  final user = FirebaseAuth.instance.currentUser;

  TextEditingController pwController = TextEditingController();
  TextEditingController newPwController = TextEditingController();
  TextEditingController newPwCheckController = TextEditingController();

  String newPwValid = "";

  Future<void> newValid() async {
    print("함수 실행");
    final userEmail = user?.email as String;
    try {
      final credential = EmailAuthProvider.credential(email: userEmail,  password: pwController.text);
      FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(credential);

      print("사용자 재인증 성공");
      newPw();
    } catch (e) {
      print("사용자 입력 정보가 정확하지 않음");
    }
  }

  Future<void> newPw() async {
    if (newPwController.text.trim() == newPwCheckController.text.trim()) {
      await user?.updatePassword(newPwController.text);
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
      }
    }
  }


  @override
  void dispose() {
    pwController.dispose();
    newPwController.dispose();
    newPwCheckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
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
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )
                    )
                  )
                ],
              ),
              SizedBox(height: 70),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "change password",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height:2),
                    Text(
                      "영어 / 숫자 / 특수문자 중\n2개 이상 조합하여 최소 8글자 "
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      enabled: false,
                      decoration: buttonDecoration.copyWith(hintText: user?.email),
                    ),
                    SizedBox(height: 14),
                    TextFormField(
                      controller: pwController,
                      decoration: buttonDecoration.copyWith(hintText: "현재 비밀번호"),
                      obscureText: true,
                    ),
                    SizedBox(height:14),
                    TextFormField(
                      controller: newPwController,
                      decoration: buttonDecoration.copyWith(hintText: "새로운 비밀번호"),
                      obscureText: true,
                    ),
                    SizedBox(height: 14),
                    TextFormField(
                      controller: newPwCheckController,
                      decoration: buttonDecoration.copyWith(hintText: "새로운 비밀번호 확인"),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: newValid,
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange
                        ),
                        child: Center(
                          child: Text(
                              "비밀번호 변경",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                            ),
                          )
                        )
                      )
                    )
                  ],
                )
              )
            ],
          )
        )
      ),
    );
  }
}
