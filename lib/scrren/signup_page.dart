import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bai_1/scrren/login_page.dart';
import 'package:flutter_bai_1/scrren/welcome_page.dart';
import 'package:flutter_bai_1/scrren/widget/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  bool checking = false;
  UserCredential? userCredential;
  RegExp regExp = RegExp(SignUpPage.pattern.toString());
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future sendData() async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);

      FirebaseFirestore.instance
          .collection('userData')
          .doc(userCredential?.user?.uid)
          .set({
        'firstName': firstName.text.trim(),
        'lastNamme': lastName.text.trim(),
        'email': email.text.trim(),
        'userid': userCredential?.user?.uid,
        'password': password.text.trim(),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The password provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('The account already exists for that email')));
      }
    } catch (e) {
      setState(() {
        checking = false;
      });
      print(userCredential);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e as String)));
    }
      setState(() {
        checking = false;
      });
  }

  void validation(context) {
    if (firstName.text.trim().isEmpty || firstName.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('FirstName is Empty')));
      return;
    }
    if (lastName.text.trim().isEmpty || lastName.text.trim() == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('LastName is Empty')));
      return;
    }
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
        setState(() {
        checking = true;
      });
      sendData();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  Widget button_SignUp(
      {required Color color,
      required String name,
      Color? text_Color,
      required BuildContext context,
      required VoidCallback ontap,
      StatefulWidget? class_name}) {
    return Container(
      height: 50,
      width: 140,
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
      // key: globalKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                ),
                Container(
                  height: 300,
                  child: Column(
                    children: [
                      MyTextField(
                        controller: firstName,
                        obscureText: false,
                        hintText: 'FirstName',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                        controller: lastName,
                        obscureText: false,
                        hintText: 'LastName',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                        controller: email,
                        obscureText: false,
                        hintText: 'Email',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                        controller: password,
                        obscureText: true,
                        hintText: ' Password',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button_SignUp(
                        color: Colors.white,
                        name: "Cancel",
                        text_Color: Colors.green,
                        context: context,
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomePage()),
                          );
                        }),
                    SizedBox(
                      width: 5,
                    ),
                    checking? CircularProgressIndicator() : button_SignUp(
                        color: Colors.green,
                        name: "Register",
                        context: context,
                        ontap: () {
                          validation(context);
                        }),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
