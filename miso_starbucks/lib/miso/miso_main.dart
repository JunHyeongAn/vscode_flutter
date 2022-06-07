import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miso_starbucks/miso/miso_1.dart';
import 'package:miso_starbucks/miso/miso_2.dart';
import 'package:miso_starbucks/miso/miso_3.dart';
import 'package:miso_starbucks/miso/miso_4.dart';

Color misoPrimaryColor = Color.fromARGB(255, 38, 103, 240);

class MisoMain extends StatefulWidget {
  const MisoMain({Key? key}) : super(key: key);
  @override
  State<MisoMain> createState() => _MisoMainState();
}

class _MisoMainState extends State<MisoMain> {
  int currIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currIdx,
        children: [
          Miso1(mainColor: misoPrimaryColor),
          Miso2(mainColor: misoPrimaryColor),
          Miso3(mainColor: misoPrimaryColor),
          Miso4(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => {
          setState(() => {currIdx = value})
        },
        selectedItemColor: misoPrimaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: currIdx,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: "miso1",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: "miso2",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gift_fill),
            label: "miso3",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_crop_circle_fill),
            label: "miso3",
          ),
        ],
      ),
    );
  }
}
