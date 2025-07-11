import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:OzO/layout/style.dart';
import 'package:OzO/sidemenu/really.dart';

class AuthUser extends StatefulWidget {
  const AuthUser({super.key});

  @override
  State<AuthUser> createState() => _AuthUserState();
}

class _AuthUserState extends State<AuthUser> {

  bool _pwVisible = false;
  TextEditingController pwController = TextEditingController();

  Future<void> _showReally() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child:  Really(
            userEmail: FirebaseAuth.instance.currentUser?.email,
            pw : pwController.text
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email;

    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70),
                      Text(
                        "비밀번호를 입력해주세요.",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 22,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        "탈퇴 시 사용자의 모든 정보가 삭제됩니다.",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13
                        ),
                      ),
                      SizedBox(height: 50),
                      TextFormField(
                        enabled: false,
                        decoration: buttonDecoration.copyWith(
                          hintText: userEmail,
                          focusColor: Colors.black54,
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: Colors.black54,
                            size: 20,
                          )
                        ),
                      ),
                      SizedBox(height: 14),
                      TextFormField(
                        obscureText: !_pwVisible,
                        controller: pwController,
                        decoration: buttonDecoration.copyWith(
                          hintText: "비밀번호",
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: Colors.black54,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _pwVisible ? Icons.visibility : Icons.visibility_off,
                              size: 18,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _pwVisible = !_pwVisible;
                              });
                            }
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      GestureDetector(
                        onTap: _showReally,
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 35,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Color(0xFFFFD4CB), Color(0xFFD1C3FF)]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "탈퇴하기",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900
                                ),
                              )
                            )
                          ),
                        )
                      )
                    ],
                  )
                )
              ),
            )
          ],
        )
      )
    );
  }
}
