import 'package:flutter/material.dart';
import 'package:OzO/style.dart';


class ZodiacSetting extends StatefulWidget {
  const ZodiacSetting({super.key});

  @override
  State<ZodiacSetting> createState() => _ZodiacSettingState();
}

class _ZodiacSettingState extends State<ZodiacSetting> {

  // 생일 선택 함수
  DateTime _selectedDate = DateTime.now();

  void _showScrollDatePicker() async {
    int tempYear = _selectedDate.year;
    int tempMonth = _selectedDate.month;
    int tempDay = _selectedDate.day;

    final yearController = FixedExtentScrollController(initialItem: tempYear - 1950);
    final monthController = FixedExtentScrollController(initialItem: tempMonth - 1);
    final dayController = FixedExtentScrollController(initialItem: tempDay - 1);

    int selectedYearIndex = _selectedDate.year - 1950;


    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 400,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = DateTime(tempYear, tempMonth, tempDay);
                      print(_selectedDate);
                    });
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment(.8, 0),
                    child: Text(
                      "done",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    )
                  )
                ),

                SizedBox(height: 10,),
                SizedBox(
                  height: 300,
                  child: SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 📆 Year picker with highlight
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 100, // 간격 조절 가능
                              child: ListWheelScrollView.useDelegate(
                                controller: FixedExtentScrollController(initialItem: selectedYearIndex),
                                itemExtent: 30,
                                diameterRatio: 1.2,
                                perspective: 0.005,
                                physics: FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    tempYear = 1950 + index;
                                    selectedYearIndex = index;
                                  });
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    bool isSelected = index == selectedYearIndex;
                                    return Center(
                                      child: Text(
                                        "${1950 + index}년",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: 100,
                                ),
                              ),
                            ),
                            IgnorePointer(
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.symmetric(
                                    horizontal: BorderSide(color: Colors.blue, width: 2),
                                  ),
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 16), // 📏 간격 추가

                        // 📆 Month picker
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: ListWheelScrollView.useDelegate(
                                controller: monthController,
                                itemExtent: 30,
                                diameterRatio: 1.2,
                                perspective: 0.005,
                                physics: FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (index) {
                                  tempMonth = index + 1;
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) => Center(
                                    child: Text(
                                      "${index + 1}월",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  childCount: 12,
                                ),
                              ),
                            ),
                            IgnorePointer(
                              child: Container(
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                  border: Border.symmetric(horizontal: BorderSide(color: Colors.blue, width: 2)),
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 16), // 📏 간격 추가

                        // 📆 Day picker
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: ListWheelScrollView.useDelegate(
                                controller: dayController,
                                itemExtent: 30,
                                diameterRatio: 1.2,
                                perspective: 0.005,
                                physics: FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (index) {
                                  tempDay = index + 1;
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) => Center(
                                    child: Text(
                                      "${index + 1}일",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  childCount: 31,
                                ),
                              ),
                            ),
                            IgnorePointer(
                              child: Container(
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                  border: Border.symmetric(horizontal: BorderSide(color: Colors.blue, width: 2)),
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
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
                            onPressed: () => _showScrollDatePicker(),
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
