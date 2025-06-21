import 'package:flutter/material.dart';

class FriendZodiac extends StatefulWidget {
  const FriendZodiac({super.key});

  @override
  State<FriendZodiac> createState() => _FriendZodiacState();
}

class _FriendZodiacState extends State<FriendZodiac> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "어쩌구저쩌구",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 70,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "쌍둥이자리",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Container(
                width: 270,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightGreen.withAlpha(102),
                      blurRadius: 4,
                      offset: Offset(-4, -4)
                    ),
                    BoxShadow(
                      color: Colors.grey.withAlpha(102),
                      blurRadius: 4,
                      offset: Offset(4, 4)
                    )
                  ]
                ),
                child: Center(
                  child: Text(
                    "어쩌구\n저쩌구\n오늘의 운세는 짜자잔\n한번더",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400

                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightGreen.withAlpha(102),
                      blurRadius: 4,
                      offset: Offset(-4, -4)
                    ),
                    BoxShadow(
                      color: Colors.grey.withAlpha(102),
                      blurRadius: 4,
                      offset: Offset(4, 4)
                    )
                  ]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.stars_rounded, color: Colors.lightGreen, size: 14),
                      SizedBox(width: 15),
                      Text(
                        "일곱색깔 무지개 빵구똥구 메롱",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
