import 'package:flutter/material.dart';
import 'screens/login_page.dart';
// import 'screens/dashboard_page.dart';
// import 'screens/register_page.dart ';
// import 'screens/otp_verification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Management',

      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),

      home: const LoginPage(),
    );
  }
}