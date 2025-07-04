import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'dart:io';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:OzO/signup.dart';
import 'package:OzO/signin.dart';
import 'package:OzO/home.dart';
import 'package:OzO/sidemenu/profileprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // WebView 플랫폼 초기화
  if (WebViewPlatform.instance == null) {
    if (Platform.isIOS) {
      WebViewPlatform.instance = WebKitWebViewPlatform();
    }
  }


  // runApp(const MaterialApp(home: MyApp()));

  runApp(
    ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 인증된 유저 아예 없을 대
          if (!authSnapshot.hasData || authSnapshot.data == null) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                    colors: [Color(0xFFD1C3FF), Color(0xFFFFD4CB)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: Image.asset("assets/images/ozo.png", width: 200,)
                  )
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 70),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUp())),
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(70),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text(
                                  "시작하기",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16
                                  ),
                                )
                              )
                            )
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn())),
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withAlpha(70)
                              ),
                              child: Center(
                                child: Text(
                                  "로그인",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800
                                  ),
                                )
                              )
                            )
                          )
                        ],
                      )
                    )
                 )
               )
             ],
           );
          }

          // 3. 로그인 상태 (유저 객체 있음)
          final user = authSnapshot.data!;
          final email = user.email;

          // 4. Firestore에서 nickname 확인
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                // 닉네임 정보가 없으면 SignIn()으로
                return SignIn();
              }
              final data = userSnapshot.data!.data() as Map<String, dynamic>;
              if (data['nickname'] != null && data['nickname'].toString().isNotEmpty) {
                // 닉네임이 있으면 Home()으로
                return Home();
              } else {
                // 닉네임이 없으면 SignIn()으로
                return SignIn();
              }
            },
          );
       },
      )
    );
  }
}


