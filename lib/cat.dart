import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  const Cat({super.key});

  static const String caturl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQEAKW_2juGPv17QlWiBFvXvvN3kQvHHjmPw&s";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("second page"),
          leading: IconButton(
              onPressed: () => {
                Navigator.pop(context)
              }, icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: Center(
          child: Column(
            children: [
              Image(image: NetworkImage(caturl)),
            ],
          ),
        ),
      ),
    );
  }
}

