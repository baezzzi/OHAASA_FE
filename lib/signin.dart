import 'package:flutter/material.dart';
import 'package:OzO/style.dart';

import 'package:OzO/auth.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  // failLogin message
  String loginMessage = "";

  // post 요청 보내기
  Future<void> signIn() async {
    final response = await http.post(
      Uri.parse("http://localhost:8080/users/sign-in"),
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode({
        "id": idController.text,
        "pw": pwController.text
      }),
    );

    if (response.statusCode == 200) {
      print("로그인 성공");
      if (mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => Auth()));
    } else {
      setState(() {
        loginMessage = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
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
                        SizedBox(height: 100,),
                        Text(
                          "log into\nyour account",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 22,

                          ),
                        )
                      ],
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      SizedBox(height: 70,),
                      Text(
                        loginMessage,
                        style: TextStyle(
                          color: Colors.deepOrange,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: idController,
                        decoration: buttonDecoration.copyWith(hintText: "아이디"),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: pwController,
                        decoration: buttonDecoration.copyWith(hintText: "비밀번호"),
                      ),
                      SizedBox(height: 50,)
                    ],
                  ),
                ),
                
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Auth()));
                  },
                  child: Center(
                    child: Container(
                      width: 330,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text(
                          "로그인",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "비밀번호 찾기",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
