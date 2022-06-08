// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class Bucket {
  String job;
  bool isDone;

  Bucket(this.job, this.isDone);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Bucket> bucketList = [];

  void showDeleteDialog(context, index, bucket) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "취소",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  bucketList.remove(bucket);
                });
                Navigator.pop(context);
              },
              child: Text(
                "확인",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("버킷리스트"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            String? job = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreatePage(),
              ),
            );
            if (job != null) {
              setState(() {
                Bucket bucket = Bucket(job, false);
                bucketList.add(bucket);
              });
            }
          },
        ),
        body: ListView.builder(
          itemCount: bucketList.length,
          itemBuilder: (context, index) {
            Bucket bucket = bucketList[index];

            return ListTile(
              title: Text(
                bucket.job,
                style: bucket.isDone
                    ? TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                        fontSize: 20,
                        decoration: TextDecoration.lineThrough)
                    : TextStyle(
                        fontSize: 20,
                      ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDeleteDialog(context, index, bucket);
                },
              ),
              onTap: () {
                setState(() {
                  bucket.isDone = !bucket.isDone;
                });
              },
            );
          },
        ));
  }
}

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController textEditingController = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷리스트 작성"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "하고 싶은 일을 입력하세요",
                errorText: error,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String job = textEditingController.text;
                  if (job.isEmpty) {
                    setState(() {
                      error = "값을 입력해주세요";
                    });
                  } else {
                    setState(() {
                      error = null;
                      Navigator.pop(context, job);
                    });
                  }
                },
                child: Text("추가하기"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
