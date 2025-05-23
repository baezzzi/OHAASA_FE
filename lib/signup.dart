import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => {
                Navigator.pop(context)
              }, icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100,),
                  Text("create"),
                  Text("your account"),
                ]
              ),
              SizedBox(height: 30,),
              TextField(
                decoration: InputDecoration(
                  labelText: "아이디",
                  labelStyle: TextStyle(color: Colors.orange),
                  focusColor: Colors.orange,
                  )
                ),
            ],
          ),
        )
      ),
    );
  }
}
