import 'package:flutter/material.dart';
import 'package:ohasa_front/signup.dart';
import 'package:ohasa_front/signin.dart';
import 'package:ohasa_front/home.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
       ),
       body: Center(
         child: Column(
           children: [

             Text("HI OHAASA"),
             SizedBox(
               height: 300,
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

             SizedBox(height: 300,),

             Row(
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
           ],
         ),
       ),
     ),
    );
  }
}

