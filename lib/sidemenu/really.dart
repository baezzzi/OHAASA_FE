import 'dart:convert';
import 'package:OzO/main.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Really extends StatefulWidget {

  final String? userEmail;
  final String pw;

  const Really({
    super.key,
    required this.userEmail,
    required this.pw,
  });

  @override
  State<Really> createState() => _ReallyState();
}

class _ReallyState extends State<Really> {

  late String? userEmail;
  late String pw;
  User? user = FirebaseAuth.instance.currentUser;
  String errMessage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userEmail = widget.userEmail;
    pw = widget.pw;
  }

  Future<void> deleteUser(userEmail, pw) async {
    try {
      var credential = EmailAuthProvider.credential(email: userEmail, password: pw);
      await user?.reauthenticateWithCredential(credential);

      final response = await http.post(
          Uri.parse("http://localhost:8080/users/delete-user"),
          headers: { "Content-Type" : "application/json" },
          body: jsonEncode({
            "email" : userEmail
          })
      );

      if (response.statusCode == 200) {
        print("사용자 삭제");
        await user?.delete();
        if (mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp()));
      }
      else {
        print(response.body);
        setState(() {
          errMessage = response.body;
        });
      }

    } catch(e) {
      print(e);
      setState(() {
        errMessage = "비밀번호가 틀렸습니다.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(102),
              blurRadius: 10,
              offset: Offset(4, 4)
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                "회원 탈퇴",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w900
                ),
              ),
              SizedBox(height: 15),
              Text(
                "회원 탈퇴 시 계정 정보는\n삭제 되어 복구할 수 없습니다.",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "정말 탈퇴하시겠습니까?",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,

                ),
              ),
              SizedBox(height: 15),
              Text(
                errMessage,
                style: TextStyle(
                  color: Color(0xFFD1C3FF),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => deleteUser(userEmail, pw),
                    child: Container(
                      width: 130,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(4, 4)
                          )
                        ]
                      ),
                      child: Center(
                        child: Text(
                          "확인",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 130,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(4, 4)
                          )
                        ]
                      ),
                      child: Center(
                        child: Text(
                          "취소",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13
                          ),
                        )
                      )
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
