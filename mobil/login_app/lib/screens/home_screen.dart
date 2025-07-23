import 'package:flutter/material.dart';
import 'package:login_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
               );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Hoş Geldiniz!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}