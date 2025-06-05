import 'package:flutter/material.dart';
import 'package:OzO/style.dart';

import 'package:scroll_date_picker/scroll_date_picker.dart';

class ZodiacSetting extends StatefulWidget {
  const ZodiacSetting({super.key});

  @override
  State<ZodiacSetting> createState() => _ZodiacSettingState();
}

class _ZodiacSettingState extends State<ZodiacSetting> {

  // 생일 선택 함수
  DateTime _selectedDate = DateTime.now();



  Widget buildDatePickerSection() {
    return Column(
      children: [
        Container(
          height: 100.0,
          alignment: Alignment.center,
          child: Text(
            "$_selectedDate",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 48),
          child: TextButton(
            onPressed: () {
              setState(() {
                _selectedDate = DateTime.now();
              });
            },
            child: Text(
              "TODAY",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: ScrollDatePicker(
            selectedDate: _selectedDate,
            locale: Locale('en'),
            onDateTimeChanged: (DateTime value) {
              setState(() {
                _selectedDate = value;
              });
            },
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: headerDecoration,
              ),
              SizedBox(height: 70,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset(
                  "assets/images/sparkle.png",
                  width: 70,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8,),
                    Text(
                      "OzO 이용을 위한\n별자리 정보를 입력하세요!",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 60,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_selectedDate.year}년 ${_selectedDate.month}월 ${_selectedDate.day}일",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 25,
                            ),
                          ),

                          IconButton(
                            onPressed: ScrollDatePicker(),
                            icon: Icon(Icons.calendar_today_rounded), color: Colors.orange,
                          )
                        ],
                      )
                    )
                  ],
                ),

              ),
              // buildDatePickerSection(),
            ],
          ),
        ],
      ),
    );
  }
}
