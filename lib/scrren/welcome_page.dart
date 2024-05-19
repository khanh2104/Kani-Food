import 'package:flutter/material.dart';
import 'package:flutter_bai_1/scrren/login_page.dart';
import 'package:flutter_bai_1/scrren/signup_page.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class WelcomePage extends StatelessWidget {
  Widget button_welcome(
      {required String name,
      required Color color,
       required StatefulWidget class_name,
      Color? color_text,
      required BuildContext context}) {
    return Container(
      height: 60,
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          side: BorderSide(color: Colors.green, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  class_name),
          );
        },
        child: Text(name, style: TextStyle(color: color_text, fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emoji = EmojiParser();
    final smiley = emoji.get('smiley');
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/burger.png',
                        width: 200,
                        height: 200,
                      ),
                      Text('KANI F&B 2023',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ]),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Text(
                    'Chào mừng bạn đến với KANI' + '\u{1F60A}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(height: 20),
                  button_welcome(
                    name: "Đăng nhập",
                    color: Colors.green,
                    color_text: Colors.white,
                    context: context,
                    class_name: LoginPage()
                    ),
                  
                  SizedBox(height: 20),
                  button_welcome(
                      name: "Đăng ký",
                      color: Colors.white,
                      color_text: Colors.green,
                      context: context,
                      class_name: SignUpPage()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
