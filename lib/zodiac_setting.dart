import 'package:flutter/material.dart';
import 'package:OzO/style.dart';
import 'package:OzO/datepicker.dart';
import 'package:OzO/home.dart';
import 'package:OzO/zodiacpicker.dart';

class ZodiacSetting extends StatefulWidget {
  const ZodiacSetting({super.key});

  @override
  State<ZodiacSetting> createState() => _ZodiacSettingState();
}

class _ZodiacSettingState extends State<ZodiacSetting> {
  // 생일 선택 함수
  DateTime _selectedDate = DateTime.now();

  Future<void> _showDatePicker() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DatePicker(
          initialDate: _selectedDate,
          onDateSelected: (pickedDate){
            setState(() {
              _selectedDate = pickedDate;
            });
          },
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    String zodiacName = getZodiacName(_selectedDate);
    return Scaffold(
      body: Stack(
        children: [
          Column(
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
                      icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
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
                            onPressed: () => _showDatePicker(),
                            icon: Icon(Icons.calendar_today_rounded), color: Colors.orange,
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 40,),
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.orange,
                              width: 2,
                            )
                          )
                        ),
                        child: Text(
                          zodiacName,
                          style: TextStyle(
                            fontSize: 30
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.05),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                },
                child: Container(
                  width: 350,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "다음",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
