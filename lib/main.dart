import 'package:easy_mtp/screens/auth/sing.dart';
import 'package:easy_mtp/screens/others/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy MTP',
      theme: ThemeData(
        useMaterial3: true,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xffff7f50),
          foregroundColor: Colors.black,
          hoverColor: Colors.red,
          splashColor: Colors.white,
        ),
      ),

      home: SignUpPage(),
    );
  }
}

