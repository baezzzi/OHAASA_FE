import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:OzO/home.dart';
import 'package:OzO/picker/datepicker.dart';
import 'package:OzO/picker/zodiacpicker.dart';
import 'package:OzO/sidemenu/authuser.dart';
import 'package:provider/provider.dart';
import 'package:OzO/sidemenu/profileprovider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String nickname = "";
  DateTime birth = DateTime.now();
  var nickChange = false;
  var birthChange = false;
  DateTime newBirth = DateTime.now();


  TextEditingController nicknameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNickname();
    getBirth();
  }
  
  // 닉네임 가져오기
  Future<void> getNickname() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final response = await http.get(
      Uri.parse("http://localhost:8080/users/find-nickname?email=$userEmail")
    );

    if (response.statusCode == 200) {
      setState(() {
        nickname = response.body;
      });
    }
  }
  
  // 닉네임 업데이트
  Future<void> updateNick() async{
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final response = await http.post(
      Uri.parse("http://localhost:8080/users/save-nickname"),
      headers: { "Content-Type" : "application/json" },
      body: jsonEncode({
        "email" : userEmail,
        "nickname" : nicknameController.text
      })
    );

    if (response.statusCode == 200) {
      print("닉네임 변경");
    }
  }
  
  // 생일 가져오기
  Future<void> getBirth() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final response = await http.get(
      Uri.parse("http://localhost:8080/users/find-birth?email=$userEmail"),
    );

    if (response.statusCode == 200) {
      setState(() {
        birth = DateTime.parse(jsonDecode(response.body));
      });
    }
  }

  // 생일 선택 함수ㅜ
  Future<void> _showDatePicker() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DatePicker(
          initialDate : birth,
          onDateSelected : (pickedDate) {
            setState(() {
              newBirth = pickedDate;
              birth = newBirth;
              birthChange = true;
            });
          }
        );
      }
    );
  }

  // 생일 업데이트
  Future<void> updateBirth() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final response = await http.post(
      Uri.parse("http://localhost:8080/users/birth?email=$userEmail"),
      headers: { "Content-Type" : "application/json" },
      body: jsonEncode({
        "birth": DateFormat('yyyy-MM-dd').format(newBirth),
        "zodiac" : getZodiacNum(newBirth)
      })
    );

    if (response.statusCode == 200) {
      print("생일 업뎃");
    }
  }

  Future<void> updateProfile() async {
    if (nicknameController.text.isNotEmpty) nickChange = true;
    print(nickChange);
    nickChange ? await updateNick() : print("nickchange");
    birthChange ? await updateBirth() : print("birthchange");
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => Home()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFFD1C3FF), Color(0xFfFFD4CB)])
              ),
            ),
            Positioned(
              top: 50,
              left: 15,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.white,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              top: 65,
              right: 30,
              child: GestureDetector(
                onTap: updateProfile,
                child: Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "done",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
              )
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 900,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60),
                        topLeft: Radius.circular(60)
                      )
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 120),
                          Text(
                            "닉네임",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                          TextField(
                            controller: nicknameController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                              hintText: nickname,
                              hintStyle: TextStyle(
                                fontSize: 20
                              )
                            ),
                          ),

                          SizedBox(height: 40),
                          Row(
                            children: [
                              Text(
                                "별자리 - ",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                              Text(
                                getZodiacName(birth),
                                style: TextStyle(
                                  color: Color(0xFFD1C3FF),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black54,
                                  width: 1
                                )
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${birth.year}년 ${birth.month}월 ${birth.day}일",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.calendar_today_rounded, color: Colors.black54),
                                  onPressed: () => _showDatePicker(),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Stack(
                    children: [
                      Consumer<ProfileProvider>(
                        builder: (context, provider, child) {
                          final imagePath = provider.profileImagePath;
                          return Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFD4CB),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 4, color: Colors.white),
                              image: imagePath != null && imagePath.isNotEmpty
                                  ? DecorationImage(
                                image: imagePath.startsWith('http')
                                    ? NetworkImage(imagePath)
                                    : FileImage(File(imagePath)) as ImageProvider,
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                          );
                        },
                      ),

                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                            if (pickedFile != null) {
                              final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
                              profileProvider.updateProfileImage(pickedFile.path); // 또는 Firebase Storage에 업로드 후 URL 저장
                            }
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 1,
                                color: Colors.black12
                              )
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Color(0xFFFFD4CB),
                              size: 15,
                            ),
                          ),
                        )
                      )
                    ],
                  )
                ],
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AuthUser())),
                    child: Text(
                      "회원 탈퇴하기",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    )
                )
              )
            )
          ],
        ),
      )
    );
  }
}
