import 'package:flutter/material.dart';

// 회원가입 입력 버튼 디자인
const InputDecoration buttonDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.orange)
  ),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.orange)
  ),
  hintStyle: TextStyle(color: Colors.orange),
);

const BoxDecoration headerDecoration = BoxDecoration(
  color: Colors.orange,
  borderRadius: BorderRadius.only(
    bottomRight: Radius.circular(50)
  )
);