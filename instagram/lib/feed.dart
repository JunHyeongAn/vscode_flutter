import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // 좋아요 여부
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.network(
            // "https://cdn2.thecatapi.com/images/kat_7kqBi.png",
            widget.imageUrl,
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: isFavorite
                  ? Icon(
                      CupertinoIcons.heart_fill,
                      color: Colors.red,
                    )
                  : Icon(CupertinoIcons.heart),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.chat_bubble),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.bookmark),
            ),
          ],
        ),

        // 좋아요
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "2 likes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // 설명
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My cat is docile even when bathed. I put a duck on his head in the wick and he's staring at me. Isn't it so cute??",
          ),
        ),

        // 날짜
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "FEBURARY 6",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
