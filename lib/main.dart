import 'package:flutter/material.dart';
import 'package:ohasa_front/signup.dart';

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
         title: const Text("Appbar"),
       ),
       body: Center(
         child: Column(
           children: [
             SizedBox(
               height: 100,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("코딩공부"),
                   SizedBox(width: 30,),
                   Text("2025"),
                 ],
               ),
             ),

             Text("hello"),
             SizedBox(
               height: 10,
             ),
             Text("data"),
             SizedBox(height: 10,),
             Icon(Icons.favorite),
             SizedBox(height: 10,),
             ElevatedButton(
                 onPressed: () => {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (_) => SignUp()))},
                 child: Text("button"))
           ],
         ),
       ),
     ),
    );
  }
}

