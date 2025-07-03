import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class Ready extends StatefulWidget {
  const Ready({super.key});

  @override
  State<Ready> createState() => _ReadyState();
}

class _ReadyState extends State<Ready> {

  late int time = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting("ko", "");
    DateTime now = DateTime.now();

    if (now.hour >= 0 && now.hour < 7) {
      setState(() {
        time = now.hour * 60 + now.minute;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 280,
                  height: 25,
                  color: Colors.grey.withAlpha(52),
                ),
                Container(
                  width: 0.66 * time,
                  height: 25,
                  color: Color(0xFFD1C3FF),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${((0.66 * time) / 420 * 100).toInt()} % ",
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12
                      ),
                    )
                  )
                )
              ],
            ),
            SizedBox(height: 10),
            Text(
              "별자리 관측하는 중 . .",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 13
              ),
            )
          ],
        ),
      )
    );
  }
}
