import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bai_1/scrren/home_page.dart';
import 'package:flutter_bai_1/scrren/signup_page.dart';
import 'package:flutter_bai_1/scrren/welcome_page.dart';
import 'package:flutter_bai_1/scrren/widget/my_text_field.dart';

class LoginPage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  UserCredential? userCredential;
  RegExp regExp = RegExp(SignUpPage.pattern.toString());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future getData(context) async {
    try {
      print('kiem tra user');
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      print(userCredential);
      if (userCredential != null) {
        print("user khong null");
        print(userCredential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      print('loi trong catch');
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User not exits')));
    }
  }

  void validation(context) {
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email is Empty')));
      return;
    } else if (!regExp.hasMatch(email.text)) {
      print('bat regex');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter valid email')));
      return;
    } else {
      print('khong regex');
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password is Empty')));
      return;
    } else {
      getData(context);
    }
  }

  Widget button_Login({
    required Color color,
    required String name,
    Color? text_Color,
    required VoidCallback ontap,
  }) {
    return Container(
      height: 50,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          side: BorderSide(color: Colors.green, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: ontap,
        child: Text(name, style: TextStyle(fontSize: 20, color: text_Color)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              );
            }),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Login In',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              // height: 200,
              child: Column(
                children: [
                  MyTextField(
                    controller: email,
                    obscureText: false,
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: password,
                    obscureText: true,
                    hintText: 'Password',
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button_Login(
                    color: Colors.green,
                    name: 'Login',
                    text_Color: Colors.white,
                    ontap: () {
                      validation(context);
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New user?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Text(
                        'Register now!',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
