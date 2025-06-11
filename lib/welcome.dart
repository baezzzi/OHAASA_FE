import 'dart:convert';

import 'package:OzO/nextbutton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:OzO/style.dart';
import 'package:OzO/home.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  Future<void> handleTutorial(BuildContext context) async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final response = await http.post(
      Uri.parse("http://localhost:8080/users/complete-tutorial"),
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode({
        "email" : userEmail
      })
    );

    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
    } else {
      print("문제발생 ${response.body}");
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
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
                  onPressed: () => Navigator.pop(context)
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              "환영합니다!!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.05),
              child: GestureDetector(
                onTap: () => handleTutorial(context),
                child: NextButton(text: "완료")
              )
            )
          )
        ],
      )
    );
  }
}
