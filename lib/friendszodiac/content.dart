import 'package:OzO/picker/colorpicker.dart';
import 'package:flutter/material.dart';

class Content extends StatefulWidget {

  final String name;
  final String zodiac;
  final String ranking;

  const Content({
    super.key,
    required this.name,
    required this.zodiac,
    required this.ranking
  });

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {

  bool isReady = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    if (now.hour >= 0 && now.hour < 7) {
      setState(() {
        isReady = true;
      });
    } else {
      setState(() {
        isReady = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Colors.black12
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(4, 4)
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
            Container(
              width: 120,
              height: 30,
              decoration: BoxDecoration(
                color: getByColor(widget.ranking.toString()),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Center(
                      child: Text(
                        isReady == true ? "★" :widget.ranking.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    )
                  ),
                  Container(
                    width: 5,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1,
                          color: Colors.white
                        )
                      )
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: Center(
                      child: Text(
                        widget.zodiac,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
}
