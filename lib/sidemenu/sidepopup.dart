import 'package:OzO/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:OzO/sidemenu/profile.dart';
import 'package:OzO/sidemenu/updatepw.dart';

class SidePopup extends StatefulWidget {
  const SidePopup({super.key});

  @override
  State<SidePopup> createState() => _SidePopupState();
}

class _SidePopupState extends State<SidePopup> {

  bool isHover = false;

  // 로그아웃
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.blueAccent,
                    child: Center(
                      child: Text(
                        "OzO",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 280,
                  height: 300,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 800,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("프로필 수정"),
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Profile())),
                            ),
                            ListTile(
                              title: Text("비밀번호 변경"),
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UpdatePw())),
                            ),
                            ListTile(
                              title: Text("공지사항"),
                            ),
                            ListTile(
                              title: Text("문의사항"),
                            ),
                            ListTile(
                              title: Text(""),
                            )
                          ],
                        ),
                      )
                    )
                  )
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 220,
                    height: 10,
                    decoration:BoxDecoration(
                        border : Border(
                            bottom: BorderSide(
                                color: Colors.black12,
                                width: 1
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: logout,
                    child: Row(
                      children: [
                        Icon(Icons.login_rounded),
                        SizedBox(width: 20,),
                        Text("로그아웃"),
                      ],
                    )
                  )

                ],
              )
            )
          )
        ],
      )
    );
  }
}
