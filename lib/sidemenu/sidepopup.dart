import 'package:OzO/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent
                  ),
                  child: Text("안녕띠"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () => Navigator.pop(context),
                        title: Text("닉네임 변경하기"),
                      ),
                      ListTile(
                        onTap: () => Navigator.pop(context),
                        title: Text("비밀번호 변경하기"),
                      ),
                    ],
                  )
                ),
              ],
            ),
            Positioned(
              bottom: 50,
              left: 100,
              child: GestureDetector(
                onTap: logout,
                child: Text("로그아웃"),
              )
            )
          ],
        )
      ),
    );
  }
}
