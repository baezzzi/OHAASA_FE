import 'package:OzO/tutorial/nick_setting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'package:OzO/signup.dart';
import 'package:OzO/signin.dart';
import 'package:OzO/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: StreamBuilder(
         stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return const Center(child: CircularProgressIndicator());
           } else if (snapshot.hasData && snapshot.data != null) {
             return Home();
           }
           return Scaffold(
             body: Stack(
               children: [
                 Center(
                   child: Column(
                     children: [
                       SizedBox(height: 300,),
                       GestureDetector(
                         onTap: () =>
                         {
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
                   child: Padding(
                     padding: EdgeInsets.only(bottom: screenHeight * .1),
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
                           onPressed: () =>
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (_) => SignUp())
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
           );
         },
      )
    );
  }
}

