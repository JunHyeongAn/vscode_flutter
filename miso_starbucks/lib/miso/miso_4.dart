import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Miso4 extends StatelessWidget {
  const Miso4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "나의 정보",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "010-9999-9999",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      // 주소관리
                      InfoList(
                        icon: Icon(
                          CupertinoIcons.home,
                          color: Colors.black,
                        ),
                        title: "주소 관리",
                      ),
                      // 주소관리 끝

                      // 결제 수단 관리
                      InfoList(
                        icon: Icon(
                          CupertinoIcons.creditcard,
                          color: Colors.black,
                        ),
                        title: "결제 수단 관리",
                      ),
                      // 결제 수단 관리 끝

                      // 주소관리
                      InfoList(
                        icon: Icon(
                          CupertinoIcons.volume_mute,
                          color: Colors.black,
                        ),
                        title: "공지사항",
                      ),
                      // 주소관리 끝
                      // 주소관리
                      InfoList(
                        icon: Icon(
                          CupertinoIcons.question_circle,
                          color: Colors.black,
                        ),
                        title: "문의사항",
                      ),
                      // 주소관리 끝
                    ],
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

class InfoList extends StatelessWidget {
  const InfoList({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
