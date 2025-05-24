import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  static const InputDecoration ButtonDecoration = InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.orange)
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.orange)
    ),
    hintStyle: TextStyle(color: Colors.orange),
  );

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 112,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50)
                )
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Text(
                    "create\nyour account",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  // 아이디 입력
                  TextField(
                    decoration: ButtonDecoration.copyWith(hintText: '아이디'),
                  ),
                  SizedBox(height: 14,),
                  // 비밀번호 입력
                  TextField(
                    decoration: ButtonDecoration.copyWith(hintText: '비밀번호'),
                  ),
                  SizedBox(height: 14,),
                  // 비밀번호 확인
                  TextField(
                    decoration: ButtonDecoration.copyWith(hintText: '비밀번호 확인'),
                  ),
                  SizedBox(height: 14,),
                  // 이메일 입력
                  TextField(
                    decoration: ButtonDecoration.copyWith(hintText: '이메일'),
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),

            GestureDetector(
              onTap: () => {
                print("회원가입 완료!")
              },
              child: Center(
                child: Container(
                  width: 330,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                      "계정생성하기",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
