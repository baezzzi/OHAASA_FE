import 'package:flutter/material.dart';


// 회원가입 입력 버튼 디자인
const InputDecoration buttonDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD1C3FF))
  ),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD1C3FF))
  ),
  hintStyle: TextStyle(color: Colors.black54),
);

const BoxDecoration headerDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [Color(0xFFD1C3FF), Color(0xFFFFD4CB)]),
  borderRadius: BorderRadius.only(
    bottomRight: Radius.circular(50)
  )
);
