import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:OzO/style.dart';

class ZodiacSetting extends StatefulWidget {
  const ZodiacSetting({super.key});

  @override
  State<ZodiacSetting> createState() => _ZodiacSettingState();
}

class _ZodiacSettingState extends State<ZodiacSetting> {

  // 생일 선택하는 거
  DateTime? selectedDate;



  // Future<void> _pickDate() async {
  //   DateTime now = DateTime.now();
  //   final DateTime? picked = await DatePicker(
  //     context: context,
  //     initialDate: selectedDate ?? now,
  //     firstDate: DateTime(1950),
  //     lastDate: DateTime(2025),
  //     locale: const Locale('ko', 'KR')
  //   ).datePikcer;
  //   if (picked != null ) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        final now = DateTime.now();
        return SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: now,
            maximumDate: now, // 오늘까지 가능
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                selectedDate = newDate;
              });
            },
          ),
        );
      },
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

                    Text(
                      selectedDate == null
                          ? "생일을 선택하시오"
                          : "${selectedDate!.year}년 ${selectedDate!.month}월 ${selectedDate!.day}일 "
                    ),
                    Text(
                      "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _showDatePicker(context),
                      child: Text("날짜 선택하기"),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
