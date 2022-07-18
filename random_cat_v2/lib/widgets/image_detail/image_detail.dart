import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:random_cat_v2/controller/cat_controller.dart';
import 'package:random_cat_v2/widgets/utils/progress.dart';

final catController = Get.find<CatController>();

class ImageDetail extends StatelessWidget {
  const ImageDetail({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: catController.getCat(Get.arguments["id"]),
        builder: (context, snapshot) {
          var content = (snapshot.connectionState == ConnectionState.done)
              ? CatImage(
                  index: Get.arguments["index"],
                )
              : WaveProgress();
          return content;
        },
      ),
    );
  }
}

class CatImage extends StatelessWidget {
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    print(
        'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  final int index;
  const CatImage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterDownloader.registerCallback(downloadCallback);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: double.infinity,
          height: 500,
          child: Obx(
            () => PhotoView(
              imageProvider: NetworkImage(
                catController.url.value,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                const _chars =
                    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                Random _rnd = Random();

                String getRandomString(int length) =>
                    String.fromCharCodes(Iterable.generate(length,
                        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

                String dir = (await getApplicationDocumentsDirectory()).path;
                String name = getRandomString(8);

                try {
                  final taskId = await FlutterDownloader.enqueue(
                        url: catController.url.value, // file url
                        savedDir: '$dir/', // 저장할 dir
                        fileName: name, // 파일명
                        saveInPublicStorage:
                            true, // 동일한 파일 있을 경우 덮어쓰기 없으면 오류발생함!
                        showNotification:
                            true, // show download progress in status bar (for Android)
                        openFileFromNotification: true,
                      ) ??
                      "";
                  print(taskId);
                  FlutterDownloader.open(taskId: taskId);
                  print("파일 다운로드 완료");
                } catch (e) {
                  print("error :::: $e");
                }
              },
              icon: Icon(
                CupertinoIcons.cloud_download,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  catController.catLike();
                  catController.updateLike(index);
                },
                icon: Obx(
                  () => Icon(
                    catController.isLike.value
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
