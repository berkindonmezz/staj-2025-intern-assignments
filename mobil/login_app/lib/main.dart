import 'package:flutter/material.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/login_screen.dart';
import 'package:login_app/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VBT PROJECT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Uygulamanın başlangıç ekranı
      home: const LoginScreen(),
    );
  }
}