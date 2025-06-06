import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:OzO/signup.dart';
import 'package:OzO/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Scaffold(
       body: Stack(
         children: [
           Center(
             child: Column(
               children: [

                 SizedBox(height: 300,),
                 Text("HI OHAASA"),
                 SizedBox(
                   height: 100,
                 ),
                 GestureDetector(
                   onTap: () => {
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (_) => SignIn())
                     ),
                   },
                   child: Container(
                     width: 280,
                     height: 50,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                       color: Colors.orange,
                       borderRadius: BorderRadius.circular(20),
                     ),
                     child: Text(
                       "로그인",
                       style: TextStyle(
                         color: Colors.white,
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           ),
           Align(
             alignment: Alignment.bottomCenter,
             child:  Padding(
               padding: EdgeInsets.only(bottom: 100),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     "계정이 없다면",
                     style: TextStyle(
                       color: Colors.grey,
                       fontSize: 15,
                     ),
                   ),
                   TextButton(
                     onPressed: () => Navigator.push(
                         context,
                       MaterialPageRoute(builder: (_) => SignUp())
                         ),
                     child: Text(
                       "회원가입",
                       style: TextStyle(
                         color: Colors.orange,
                         fontSize: 15,
                       ),
                     )
                   ),
                 ],
               )
             )
           )
         ],
       ),
     ),
    );
  }
}

