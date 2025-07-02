import 'package:OzO/main.dart';
import 'package:OzO/noticepage/webviewpage.dart';
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFFD1C3FF), Color(0xFFFFD4CB)])
                  ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          "assets/images/ozo.png",
                          width: 150,
                          color: Colors.black54,
                        ),
                      ],
                    )
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
                              title: Text("문의사항"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewPage(
                                      url: "https://docs.google.com/forms/u/1/d/e/1FAIpQLSdf35boJHO61I0yJTHCFoWXBPGPMifNqZtl8KIAG4nwv3pVsw/formResponse"
                                    )
                                  )
                                );
                              },
                            ),
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
                  Text(
                    "💌 OzO 메일\nmycodingnumber100@gmail.com",
                    style: TextStyle(
                      fontSize: 12
                    ),
                  ),
                  SizedBox(height: 10),
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
