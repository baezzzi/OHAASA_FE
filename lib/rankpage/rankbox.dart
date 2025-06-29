import 'package:flutter/material.dart';

import 'package:OzO/picker/colorpicker.dart';

class RankBox extends StatefulWidget {

  final String ranking;
  final String name;

  const RankBox({
    super.key,
    required this.ranking,
    required this.name
  });

  @override
  State<RankBox> createState() => _RankBoxState();
}

class _RankBoxState extends State<RankBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: getByColor(widget.ranking),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50,
            child: Center(
              child: Text(
                widget.ranking,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: Text(
                widget.name,
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: getByColor(widget.ranking),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)
              )
            ),
          )
        ],
      ),
    );
  }
}
