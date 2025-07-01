import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateFriend extends StatefulWidget {

  final String id;

  const UpdateFriend({
    super.key,
    required this.id,
  });

  @override
  State<UpdateFriend> createState() => _UpdateFriendState();
}

class _UpdateFriendState extends State<UpdateFriend> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> getFriend() async {
    final response = await http.get(
      Uri.parse("http://localhost:8080/friend/update-friend?id=${widget.id}")
    );

    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "cancle",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w700
                        ),
                      )
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "done",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 13
                        ),
                      )
                    )
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "이름",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                      Material(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "친구 이름",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            filled: true,
                            fillColor: Colors.white
                          ),
                        ),
                      ),

                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            "별자리 - ",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              fontSize: 16
                            ),
                          ),
                          Text(
                            "hello",
                            style: TextStyle(
                              color: Color(0xFFD1C3FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Colors.black54
                            )
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.calendar_today_rounded, color: Colors.black54, size: 18,),
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
