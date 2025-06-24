import 'package:flutter/material.dart';

final List<Map<String, dynamic>> zodiacList = [
  {
    "name" : "염소자리",
    "start" : DateTime(0, 12, 25),
    "end" : DateTime(0, 1, 19),
    "num" : 1,
    "en" : "capricorn"
  },
  {
    "name" : "물병자리",
    "start" : DateTime(0, 1, 20),
    "end" : DateTime(0, 2, 18),
    "num" : 2,
    "en" : "aquarius"
  },
  {
    "name" : "물고기자리",
    "start" : DateTime(0, 2, 19),
    "end" : DateTime(0, 3, 20),
    "num" : 3,
    "en" : "pisces"
  },
  {
    "name" : "양자리",
    "start" : DateTime(0, 3, 21),
    "end" : DateTime(0, 4, 20),
    "num" : 4,
    "en" : "aries"
  },
  {
    "name" : "황소자리",
    "start" : DateTime(0, 4, 21),
    "end" : DateTime(0, 5, 20),
    "num" : 5,
    "en" : "taurus"
  },
  {
    "name" : "쌍둥이자리",
    "start" : DateTime(0, 5, 21),
    "end" : DateTime(0, 6, 21),
    "num" : 6,
    "en" : "gemini"
  },
  {
    "name" : "게자리",
    "start" : DateTime(0, 6, 22),
    "end" : DateTime(0, 7, 22),
    "num" : 7,
    "en" : "cancer"
  },
  {
    "name" : "사자자리",
    "start" : DateTime(0, 7, 23),
    "end" : DateTime(0, 8, 22),
    "num" : 8,
    "en" : "leo"
  },
  {
    "name" : "처녀자리",
    "start" : DateTime(0, 8, 23),
    "end" : DateTime(0, 9, 23),
    "num" : 9,
    "en" : "virgo"
  },
  {
    "name" : "천칭자리",
    "start" : DateTime(0, 9, 24),
    "end" : DateTime(0, 10, 22),
    "num" : 10,
    "en" : "libra"
  },
  {
    "name" : "전갈자리",
    "start" : DateTime(0, 10, 23),
    "end" : DateTime(0, 11, 22),
    "num" : 11,
    "en" : "scorpio"
  },
  {
    "name" : "사수자리",
    "start" : DateTime(0, 11, 23),
    "end" : DateTime(0, 12, 24),
    "num" : 12,
    "en" : "sagittarius"
  }
];
class ZodiacPicker extends StatefulWidget {

  final DateTime selectedDate;
  // final String zodiac;

  const ZodiacPicker({
    super.key,
    required this.selectedDate,
    // required this.zodiac,
  });

  @override
  State<ZodiacPicker> createState() => _ZodiacPickerState();
}

// 별자리 찾는 함수
String getZodiacName(DateTime selectedDate) {

  int month = selectedDate.month;
  int day = selectedDate.day;

  for (var zodiac in zodiacList) {
    DateTime start = zodiac['start'];
    DateTime end = zodiac['end'];

    if (start.month == 12 && end.month == 1) {
      if ((month == 12 && day >= start.day) || ((month == 1) && day <= end.day)) {
        return zodiac['name'];
      }
    } else {
      if ((month == start.month && day >= start.day) ||
          (month == end.month && day <= end.day) ||
          (month > start.month && month < end.month)) {
        return zodiac['name'];
      }
    }
  }
  return "알수 없음";
}

int getZodiacNum(DateTime selectedDate) {
  int month = selectedDate.month;
  int day = selectedDate.day;

  for (var zodiac in zodiacList) {
    DateTime start = zodiac['start'];
    DateTime end = zodiac['end'];

    if (start.month == 12 && end.month == 1) {
      if ((month == 12 && day >= start.day) || ((month == 1) && day <= end.day)) {
        return zodiac['num'];
      }
    } else {
      if ((month == start.month && day >= start.day) ||
          (month == end.month && day <= end.day) ||
          (month > start.month && month < end.month)) {
        return zodiac['num'];
      }
    }
  }
  return 0;
}

String getNameByNum(String num) {
  for (var zodiac in zodiacList) {
    String name = zodiac['name'];
    String zonum = zodiac['num'].toString();
    if (zonum == num) return name;
  }
  return "해당 없음";
}

String getEnName(String num) {
  for (var zodiac in zodiacList) {
    String en = zodiac['en'];
    String zonum = zodiac['num'].toString();

    if (zonum == num) {
      return en;
    }
  }
  return "해당 없음";
}

String changeEnToKo(String enName) {
  for (var zodiac in zodiacList) {
    String en = zodiac['en'];
    String ko = zodiac['name'];
    if (en == enName) {
      return ko;
    }
  }
  return "해당 없음";
}

String changeKoToEn(String name) {
  for (var zodiac in zodiacList) {
    String en = zodiac["en"];
    String ko = zodiac["name"];
    if (ko == name) {
      return en;
    }
  }
  return "해당 없ㅇ므";
}

// friend 별자리 찾는 함수
String frZodiacName(DateTime selectedDate) {

  int month = selectedDate.month;
  int day = selectedDate.day;

  for (var zodiac in zodiacList) {
    DateTime start = zodiac['start'];
    DateTime end = zodiac['end'];

    if (start.month == 12 && end.month == 1) {
      if ((month == 12 && day >= start.day) || ((month == 1) && day <= end.day)) {
        return zodiac['en'];
      }
    } else {
      if ((month == start.month && day >= start.day) ||
          (month == end.month && day <= end.day) ||
          (month > start.month && month < end.month)) {
        return zodiac['en'];
      }
    }
  }
  return "알수 없음";
}

class _ZodiacPickerState extends State<ZodiacPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
