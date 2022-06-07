import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Miso2 extends StatelessWidget {
  const Miso2({Key? key, required this.mainColor}) : super(key: key);
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    Text(
                      "예약내역",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              CupertinoIcons.exclamationmark_circle_fill,
                              color: mainColor,
                            ),
                          ),
                          Text("예약된 서비스가 아직 없어요. 지금 예약해보세요!"),
                          Divider(color: Colors.grey),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // button

              GestureDetector(
                onTap: () => {
                  print("Tap 예약하기"),
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width - 30,
                      height: 58,
                      child: Center(
                        child: Text(
                          "예약하기",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
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
