import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Rank extends StatefulWidget {
  const Rank({super.key});

  @override
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {

  Future<void> getZodiac() async {
    final response = await http.get(
      Uri.parse("http://localhost:8080/zodiac/today"),
      headers: { "Content-Type" : "application/json"}
    );

    print("Click");
    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
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
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60)
                        )
                      ),
                      child: Column(
                        children: [
                          Text("hl"),
                          GestureDetector(
                            onTap: getZodiac,
                            child: Text("Click"),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withAlpha(102),
                      blurRadius: 10,
                      offset: Offset(-4, -4)
                  )
                ]
            ),
            child: Align(
              alignment: Alignment(0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.menu_rounded, color: Colors.pinkAccent, size: 50,),
                  Icon(Icons.favorite_rounded, color: Colors.pinkAccent, size: 50,),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Rank()));
                      },
                      child: Icon(Icons.extension_rounded, color: Colors.pinkAccent, size: 50,)
                  )
                ],
              ),
            )
        ),
      )
    );
  }
}
