import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {

  final DateTime initialDate;
  final void Function(DateTime) onDateSelected;

  const DatePicker({
    Key? key,
    required this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  late int tempYear;
  late int tempMonth;
  late int tempDay;

  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempYear = widget.initialDate.year;
    tempMonth = widget.initialDate.month;
    tempDay = widget.initialDate.day;

    yearController = FixedExtentScrollController(initialItem: tempYear - 1950);
    monthController = FixedExtentScrollController(initialItem: tempMonth - 1);
    dayController = FixedExtentScrollController(initialItem: tempDay - 1);
  }

  // 메모리 누수 방지
  @override
  void dispose() {
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.onDateSelected(DateTime(tempYear, tempMonth, tempDay));
              });
              Navigator.pop(context);
            },
            child: Align(
              alignment: Alignment(.8, 0),
              child: Text(
                "done",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),
          SizedBox(
            height: 300,
            child: SizedBox(
              width: double.infinity,
              height: 300,
              child: Stack(
                children: [
                  IgnorePointer(
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Color(0xFFDDDDDD),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: ListWheelScrollView.useDelegate(
                          controller: yearController,
                          itemExtent: 40,
                          diameterRatio: 1.2,
                          perspective: 0.005,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              tempYear = 1950 + index;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Center(
                                child: Text(
                                  "${1950 + index}년",
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                ),
                              );
                            },
                            childCount: 100,
                          ),
                        ),
                      ),

                      SizedBox(width: 16,),

                      SizedBox(
                        width: 100,
                        child: ListWheelScrollView.useDelegate(
                          controller: monthController,
                          itemExtent: 40,
                          diameterRatio: 1.2,
                          perspective: 0.005,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              tempMonth = index + 1;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Center(
                                child: Text(
                                  "${index + 1}월",
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                )
                              );
                            },
                            childCount: 12
                          ),
                        ),
                      ),

                      SizedBox(width: 16,),
                      SizedBox(
                        width: 100,
                        child: ListWheelScrollView.useDelegate(
                          controller: dayController,
                          itemExtent: 40,
                          diameterRatio: 1.2,
                          perspective: 0.005,
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              tempDay = index + 1;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return  Center(
                                child: Text(
                                  "${index + 1}일",
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                ),
                              );
                            },
                            childCount: 31
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
