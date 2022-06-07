import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Miso3 extends StatelessWidget {
  const Miso3({Key? key, required this.mainColor}) : super(key: key);
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mainColor,
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: NetworkImage(
              "https://i.ibb.co/rxzkRTD/146201680-e1b73b36-aa1e-4c2e-8a3a-974c2e06fa9d.png"),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 95),
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    "친구를 추천할 때마다\n 10,000원 할인쿠폰 지급!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    "자세히 보기>",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Colors.grey,
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print("Press 친구 추천하기");
                  },
                  child: SizedBox(
                    width: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.gift_fill,
                          color: mainColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "친구 추천하기",
                            style: TextStyle(
                              color: mainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
