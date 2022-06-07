import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miso_starbucks/starbucks/starbucks1.dart';
import 'package:miso_starbucks/starbucks/starbucks2.dart';
import 'package:miso_starbucks/starbucks/starbucks3.dart';

class StartBucksMain extends StatefulWidget {
  const StartBucksMain({Key? key}) : super(key: key);

  @override
  State<StartBucksMain> createState() => _StartBucksMainState();
}

class _StartBucksMainState extends State<StartBucksMain> {
  int currIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: currIdx == 3 || currIdx == 4 ? 0 : currIdx,
          children: [
            Starbucks1(),
            Starbucks2(),
            Starbucks3(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        onTap: (value) => {setState(() => currIdx = value)},
        currentIndex: currIdx,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
            ),
            label: "1",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.creditcard,
            ),
            label: "2",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.free_breakfast),
            label: "3",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.gift,
            ),
            label: "4",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.more_horiz,
            ),
            label: "4",
          )
        ],
      ),
    );
  }
}
