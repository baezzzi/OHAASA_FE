import 'package:flutter/material.dart';

import 'package:OzO/layout/style.dart';
import 'package:OzO/webviewpage.dart';

class Notice extends StatefulWidget {
  const Notice({super.key});

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: headerDecoration,
                ),
                Positioned(
                  top: 80,
                  left: 15,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    )
                  )
                )
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 900,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),

                        Text(
                          "공지사항",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            fontSize: 18
                          ),
                        ),
                        
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => WebViewPage(
                                  url: "https://stupendous-pastry-406.notion.site/223b7f5885d4807284dae6b02deffa48?source=copy_link"
                                )
                              )
                            );
                          },

                          child: Stack(
                            children: [
                              Container(
                                width: 300,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFD4CB),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey.withAlpha(102)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withAlpha(102),
                                      blurRadius: 4,
                                      offset: Offset(4,4)
                                    )
                                  ]
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 0,
                                child: Container(
                                  width: 300,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "OzO 1.0 출시!",
                                      style: TextStyle(
                                        color: Colors.black54
                                      ),
                                    )
                                  ),
                                )
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  )
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
