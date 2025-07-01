import 'package:flutter/material.dart';

import 'package:OzO/layout/style.dart';
import 'package:OzO/noticepage/webviewpage.dart';
import 'package:OzO/noticepage/noticecontainer.dart';

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
                          child: NoticeContainer(header: "OzO 1.0 출시")
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
