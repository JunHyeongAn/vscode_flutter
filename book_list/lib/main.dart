import 'package:book_list/book.dart';
import 'package:book_list/bookService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            SliverHeader(),
          ],
        ),
      ),
    );
  }
}

class SliverHeader extends StatefulWidget {
  const SliverHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<SliverHeader> createState() => _SliverHeaderState();
}

class _SliverHeaderState extends State<SliverHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookService>(
      builder: (context, bookService, child) {
        List<Book> bookList = bookService.bookList;
        return CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              bookService: bookService,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Book book = bookList[index];
                    return BookCard(
                      imageUrl: book.smallThumbnail,
                      bookTitle: book.title,
                      bookDes: book.description,
                    );
                  },
                ),
              )
            ]))
          ],
        );
      },
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard(
      {Key? key,
      required this.imageUrl,
      required this.bookTitle,
      required this.bookDes})
      : super(key: key);
  final imageUrl;
  final bookTitle;
  final bookDes;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          //////////////
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 210,
                  child: Text(
                    bookTitle,
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: Text(
                    "hello",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
    required this.bookService,
  }) : super(key: key);
  final BookService bookService;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
      pinned: true, // 스크롤시 bottom 영역을 화면 상단에 남길지 여부
      snap: false, // 중간에 멈출 때 자동으로 AppBar를 펼쳐서 배경을 모두 보여줄지
      floating: true, // AppBar를 화면에 띄울지, 아니면 컬럼처럼 최 상단에 놓을지
      expandedHeight: 150, // 최대 확장되었을 떄 높이
      backgroundColor: Colors.white,

      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Book Store",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "total 40",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          // 검색창
          child: TextField(
            onSubmitted: (value) {
              bookService.getBookList(value);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
              suffixIcon: Icon(
                Icons.search,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
