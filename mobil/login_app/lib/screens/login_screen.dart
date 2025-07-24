import 'package:flutter/material.dart';
import 'package:login_app/models/user_model.dart';
import 'package:login_app/services/auth_service.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/register_screen.dart';

/// A screen that provides a user interface for user authentication.
///
/// This widget is stateful because it needs to manage the state of
/// input fields and the loading status during an API call.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers to read the text input from the email and password fields.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // A boolean flag to manage the loading state of the login process.
  // Used to show a progress indicator and disable the button during the API call.
  bool _isLoading = false;

  // An instance of the AuthService to handle the login logic.
  final AuthService _authService = AuthService();

  /// Handles the login process when the user taps the login button.
  Future<void> _login() async {
    // Set the loading state to true to update the UI.
    setState(() {
      _isLoading = true;
    });

    try {
      // Attempt to log in by calling the login method from AuthService.
      await _authService.login(
        _emailController.text,
        _passwordController.text,
      );

      // If login is successful, navigate to the HomeScreen.
      // pushReplacement is used to prevent the user from going back to the login screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      // If an error occurs during login, display an error message in a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Giriş başarısız: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Regardless of success or failure, set the loading state back to false.
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Cleans up the controllers when the widget is removed from the widget tree.
  /// This is important for memory management.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              // The button is disabled and shows a loading indicator if _isLoading is true.
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Giriş'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the registration screen.
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('Hesabın yok mu? Kayıt ol'),
            ),
          ],
        ),
      ),
    );
  }
}
