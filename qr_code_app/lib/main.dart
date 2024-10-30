import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_app/screens/first_page.dart';
import 'package:qr_code_app/screens/qr_scanner_screen.dart';
import 'package:qr_code_app/screens/sign_in_screen.dart';
import 'package:qr_code_app/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
       
    );

  }
}
