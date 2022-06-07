// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Miso1 extends StatelessWidget {
  Miso1({Key? key, required this.mainColor}) : super(key: key);
  final Color mainColor;

  final TextStyle mainTextStyle = TextStyle(
    fontSize: 35,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Text(
                    "대한민국 1등 홈서비스\n미소를 만나보세요",
                    textAlign: TextAlign.center,
                    style: mainTextStyle,
                  ),
                  SizedBox(height: 38),
                  ElevatedButton(
                    onPressed: () {
                      print("Tap 예약하기");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.add,
                            color: mainColor,
                          ),
                          Text(
                            "예약하기",
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // 서비스 상세 정보
              Positioned(
                bottom: 32,
                child: GestureDetector(
                  onTap: () {
                    print("Tap 서비스 상세정보");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    color: Colors.white.withOpacity(0.5),
                    child: Text(
                      "서비스 상세정보",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
