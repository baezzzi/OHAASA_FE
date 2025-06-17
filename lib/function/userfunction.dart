import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UserFunction extends StatelessWidget {
  const UserFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

Future<String> getNickname() async{
  final userEmail = FirebaseAuth.instance.currentUser?.email;
  final response = await http.get(
    Uri.parse("http://localhost:8080/user/find-nickname?email=$userEmail"),
    headers: { "Content-Type" : "application/json"}
  );

  if (response.statusCode == 200) {
    final nickname = response.body;
    return nickname;
  } else {
    return "헤이";
  }
}
