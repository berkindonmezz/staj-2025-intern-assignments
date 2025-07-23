import 'package:flutter/material.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true, // Şifrenin gizlenmesi için
              decoration: InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
					MaterialPageRoute(builder: (context) => const HomeScreen()),
				);
              },
              child: const Text('Giriş Yap'),
            ),
            TextButton(
              onPressed: () {
                 Navigator.of(context).push(
					MaterialPageRoute(builder: (context) => const RegisterScreen()),
				);
              },
              child: const Text('Hesabın yok mu? Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}