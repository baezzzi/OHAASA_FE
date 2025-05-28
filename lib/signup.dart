import 'package:flutter/material.dart';
import 'style.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // 키보드 숨기기
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Stack(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: headerDecoration,
                    ),
                    Positioned(
                      top: 80,
                      left: 15,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      SizedBox(height: 100),
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
                      Stack(
                        children: [
                          // 아이디 입력
                          TextField(
                            decoration: buttonDecoration.copyWith(hintText: '아이디'),
                          ),
                          Positioned(
                            top: 10,
                            right: 0,
                            child: Container(
                              width: 70,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "중복확인",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 14,),
                      // 비밀번호 입력
                      TextField(
                        decoration: buttonDecoration.copyWith(hintText: '비밀번호'),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 14,),
                      // 비밀번호 확인
                      TextField(
                        decoration: buttonDecoration.copyWith(hintText: '비밀번호 확인'),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 14,),
                      // 이메일 입력
                      TextField(
                        decoration: buttonDecoration.copyWith(hintText: '이메일'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () => {
                    print("회원가입 완료!"),
                    Navigator.pop(context)
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
        ),
      ),
    );
  }
}
