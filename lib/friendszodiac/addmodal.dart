import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:OzO/picker/datepicker.dart';
import 'package:OzO/picker/zodiacpicker.dart';
import 'package:OzO/friendszodiac/friend.dart';

class AddModal extends StatefulWidget {
  const AddModal({super.key});

  @override
  State<AddModal> createState() => _AddModalState();
}

class _AddModalState extends State<AddModal> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();
  TextEditingController nameController = TextEditingController();

  Future<void> _showDatePicker() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return DatePicker(
              initialDate: _selectedDate,
              onDateSelected: (pickedDate) {
                setState(() {
                  _selectedDate = pickedDate;
                  print(getZodiacName(pickedDate));
                });
              }
          );
        }
    );
  }

  Future<void> addFriend() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final response = await http.post(
      Uri.parse("http://localhost:8080/friend/add-friend"),
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode({
        "email" : userEmail,
        "name" : nameController.text.trim(),
        "birth" : DateFormat("yyyy-MM-dd").format(_selectedDate),
        "zodiac" : frZodiacName(_selectedDate)
      })
    );

    if (response.statusCode == 200) {
      print("성공");
      print(response.body);
      if (mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => Friend()));
    } else {
      print("잘 안 됐음 : ${response.body}");
    }
  }


  @override
  Widget build(BuildContext context) {
    String zodiacName = getZodiacName(_selectedDate);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
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
                        )
                      ),
                    ),
                    TextButton(
                      onPressed: addFriend,
                      child: Text(
                        "add",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            filled: true,
                            fillColor: Colors.white
                          )
                        )
                      ),

                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            "별자리 - ",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                          Text(
                            zodiacName,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),
                          ),
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
                              "${_selectedDate.year}년 ${_selectedDate.month}월 ${_selectedDate.day}일",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            IconButton(
                              onPressed: () => _showDatePicker(),
                              icon: Icon(Icons.calendar_today_rounded, color: Colors.black54, size: 18,))
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
  }
}
