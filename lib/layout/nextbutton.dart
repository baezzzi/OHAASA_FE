import 'package:flutter/material.dart';

class NextButton extends StatefulWidget {
  final String text;

  const NextButton({super.key, required this.text});

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFFFD4CB), Color(0xFFD1C3FF)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900
          ),
        ),
      )
    );
  }
}
