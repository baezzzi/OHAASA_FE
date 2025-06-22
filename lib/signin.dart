import 'package:OzO/home.dart';
import 'package:flutter/material.dart';
import 'package:OzO/layout/style.dart';
import 'package:OzO/tutorial/auth.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  // failLogin message
  String loginMessage = "";

  Future<void> signIn() async {
    print("로그인 실행");
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: pwController.text.trim()
      );

      if (mounted) {
        print("로그인 성공");
        checkFirstLogin();
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      setState(() {
        loginMessage = "아이디 혹은 비밀번호가 틀렸습니다.";

      });
    } catch (e) {
      print(e);
    }
  }

  // tutorial t/f
  Future<void> checkFirstLogin() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    print(userEmail);

    final response = await http.get(
      Uri.parse("http://localhost:8080/users/is-first-login?email=$userEmail"),
      headers: {"Content-Type" : "application/json"}
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final isFirst = data['firstLogin'];

      print(isFirst);

      if (isFirst == true) {
        if(mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => Auth()));
      } else {
        if(mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
      }
    } else {
      print("서버 오류 ${response.statusCode}");
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
                        controller: emailController,
                        decoration: buttonDecoration.copyWith(hintText: "이메일"),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: pwController,
                        decoration: buttonDecoration.copyWith(hintText: "비밀번호"),
                        obscureText: true,
                      ),
                      SizedBox(height: 50,)
                    ],
                  ),
                ),
                
                GestureDetector(
                  onTap: signIn,
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
