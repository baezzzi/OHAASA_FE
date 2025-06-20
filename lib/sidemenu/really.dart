import 'package:flutter/material.dart';

class Really extends StatefulWidget {
  const Really({super.key});

  @override
  State<Really> createState() => _ReallyState();
}

class _ReallyState extends State<Really> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(4, 4)
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                "회원 탈퇴",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800
                ),
              ),
              SizedBox(height: 15),
              Text(
                "회원 탈퇴 시 계정 정보는\n삭제 되어 복구할 수 없습니다.",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "정말 탈퇴하시겠습니까?",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,

                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 130,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(4, 4)
                          )
                        ]
                      ),
                      child: Center(
                        child: Text(
                          "확인",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 130,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        // border : Border.all(
                        //     width: 1,
                        //     color: Colors.black54
                        // ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(4, 4)
                          )
                        ]
                      ),
                      child: Center(
                        child: Text(
                          "취소",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13
                          ),
                        )
                      )
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
