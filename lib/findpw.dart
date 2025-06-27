import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:OzO/layout/style.dart';

class FindPw extends StatefulWidget {
  const FindPw({super.key});

  @override
  State<FindPw> createState() => _FindPwState();
}

class _FindPwState extends State<FindPw> {

  final user = FirebaseAuth.instance.currentUser;
  TextEditingController emailController = TextEditingController();
  bool isValid = false;
  String validMessage = "";

  Future<void> checkValid() async {
    final response = await http.get(
      Uri.parse("http://localhost:8080/users/find-user?email=${emailController.text.trim()}")
    );
    print("실행함");

    if (response.statusCode == 200) {
      await FirebaseAuth.instance.setLanguageCode("ko");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
    } else {
      setState(() {
        validMessage = "해당 이메일의 사용자가 존재하지 않습니다.";
      });
    }
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Text(
                      "find password",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${emailController.text}으로\n메일이 전송됩니다.\n링크를 클릭해 비밀번호 재설정해주세요.",
                      style: TextStyle(
                        fontSize: 14
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      decoration: buttonDecoration.copyWith(hintText : "이메일"),
                    ),
                    SizedBox(height:14),
                    GestureDetector(
                      onTap: checkValid,
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "비밀번호 변경",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12
                            ),
                          )
                        )
                      )
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        validMessage,
                        style: TextStyle(
                            color: Colors.purple
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        )
      )
    );
  }
}
