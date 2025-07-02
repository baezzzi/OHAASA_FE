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
  Color(0xFFFF8181), // 1등
  Color(0xFFFF9D60), // 2등
  Color(0xFFFFDC4D),  // 3등
  Color(0xFF9AD389), // 5-8등
  Color(0xFF96B2F4), // 9-11등
  Color(0xFF4D89FF),
  Color(0xFF364C9A), // 12등
  Color(0xFFC487FA),
  Color(0xFFFA91D4),
  Color(0xFFA1A1A1),
  Color(0xFF936351),
  Color(0xFF131313),
  // Color(0xFF8F232D)
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
