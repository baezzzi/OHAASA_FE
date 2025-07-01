import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:OzO/layout/nextbutton.dart';
import 'package:OzO/layout/style.dart';
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Column(
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
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 200,),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0x55FFD4CB)
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Color(0xFFD1C3FF),
                            )
                          )
                        ),
                        SizedBox(height: 30),
                        Text(
                          "OzO 이용 준비 완료!",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    )
                  ),
                )
              ],
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
      )
    );
  }
}
