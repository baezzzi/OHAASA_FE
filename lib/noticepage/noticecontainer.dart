import 'package:flutter/material.dart';

class NoticeContainer extends StatefulWidget {
  final String header;
  const NoticeContainer({
    super.key,
    required this.header
  });

  @override
  State<NoticeContainer> createState() => _NoticeContainerState();
}

class _NoticeContainerState extends State<NoticeContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Color(0xFFFFD4CB),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 0.5,
                  color: Colors.grey.withAlpha(102)
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withAlpha(102),
                    blurRadius: 4,
                    offset: Offset(4,4)
                )
              ]
          ),
        ),
        Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    widget.header,
                    style: TextStyle(
                        color: Colors.black54
                    ),
                  )
              ),
            )
        )
      ],
    );
  }
}
