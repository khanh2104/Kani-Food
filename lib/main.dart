import 'package:flutter/material.dart';
import 'package:flutter_bai_1/provider/my_provider.dart';
import 'package:flutter_bai_1/scrren/home_page.dart';
import 'package:flutter_bai_1/scrren/signup_page.dart';
import 'package:flutter_bai_1/scrren/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MyProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KANI FOOD',
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: Colors.green,
        )),
        home: WelcomePage(),
      ),
    );
  }
}
