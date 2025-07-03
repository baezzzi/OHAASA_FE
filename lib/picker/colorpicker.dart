import 'package:flutter/material.dart';

// FFD4CB  - 핑크
// D1C3FF  - 보라

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

// 순위에 따른 색
final List<Color> colors = [
  Color(0xFFFF8888), // 1등
  Color(0xFFFFB8DE), // 2등
  Color(0xFFFFCCA6), // 3등
  Color(0xFFBFE6AF), // 4등
  Color(0xFF94B4C3), // 5등
  Color(0xFFBBE5F1), // 6등
  Color(0xFFC7D6FF), // 7등
  Color(0xFFDBCEFF), // 8등
  Color(0xFF8987A8), // 9등
  Color(0xFFC7A2A2), // 10등
  Color(0xFFC8C8C8), // 11등
  Color(0xFF727272), // 12등
];

Color getByColor(String ranking) {
  switch (ranking) {
    case "1" : return colors[0];
    case "2": return colors[1];
    case "3": return colors[2];
    case "4": return colors[3];
    case "5": return colors[4];
    case "6": return colors[5];
    case "7": return colors[6];
    case "8": return colors[7];
    case "9": return colors[8];
    case "10": return colors[9];
    case "11": return colors[10];
    case "12": return colors[11];
    default:
      return Color(0xFFD1C3FF);

  }
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
