import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Naver Log In",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Roboto"),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Kakao Log In",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Roboto"),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Google Log In",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Roboto"),
            ),
          ),
        ],
      ),
    );
  }
}
