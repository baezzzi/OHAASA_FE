import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

// 순위에 따른 색
final List<Color> colors = [
  Color(0xFFFA8B8B), // 1등
  Color(0xFFFFA069), // 2-4등
  Color(0xFF9AD389), // 5-8등
  Color(0xFF8CA8EA), // 9-11등
  Color(0xFF313857), // 12등
];

Color getByColor(String ranking) {
  switch (ranking) {
    case "1" : return colors[0];
    case "2":
    case "3":
    case "4":
      return colors[1];
    case "5":
    case "6":
    case "7":
      return colors[2];
    case "8":
    case "9":
    case "10":
    case "11":
      return colors[3];
    case "12":
      return colors[4];
    default:
      return Colors.purpleAccent;
  }
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
