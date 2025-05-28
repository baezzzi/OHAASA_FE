import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // 이미지 변수 생성
  File? _imageFile;

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: 930,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                ),
                Align(
                  alignment: Alignment(0, 1),
                  child: Container(
                    width: double.infinity,
                    height: 800,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),

                    child: Column(
                      children: [
                        SizedBox(height: 90,),
                        Text(
                          "닉네임",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "쌍둥이자리",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -.8),
                  child: GestureDetector(
                    onTap: _pickImage,

                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 8,
                          color: Colors.white,
                        ),
                        image: _imageFile != null
                          ? DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        ) : null,
                      ),
                      child: _imageFile == null
                        ? const Icon(Icons.face, color: Colors.white, size: 100,)
                          : null,
                    ),
                  )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
