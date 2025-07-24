import 'package:flutter/material.dart';
import 'package:login_app/services/auth_service.dart';

/// A screen that provides a user interface for new user registration.
///
/// This widget is stateful to manage multiple text input fields and the
/// loading state during the registration API call.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers for all the required input fields for registration.
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _roleController = TextEditingController();

  // A boolean flag to manage the loading state.
  bool _isLoading = false;
  
  // An instance of the AuthService to handle the registration logic.
  final AuthService _authService = AuthService();

  /// Handles the registration process when the user taps the register button.
  Future<void> _register() async {
    // First, perform a client-side validation to check if passwords match.
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Şifreler eşleşmiyor!'),
          backgroundColor: Colors.orange,
        ),
      );
      return; // Stop the process if passwords don't match.
    }

    // Set the loading state to true to update the UI.
    setState(() { _isLoading = true; });

    try {
      // Attempt to register by calling the register method from AuthService.
      await _authService.register(
        username: _usernameController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        role: _roleController.text,
      );

      // If registration is successful, show a success message and navigate back.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kayıt başarılı! Lütfen giriş yapın.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop(); // Go back to the previous screen (LoginScreen).

    } catch (e) {
      // If an error occurs, display the error message from the server.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kayıt başarısız: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Always set the loading state back to false when the process is complete.
      setState(() { _isLoading = false; });
    }
  }

  /// Cleans up all the controllers when the widget is disposed.
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt ol'),
        centerTitle: true,
      ),
      // SingleChildScrollView prevents the UI from overflowing when the keyboard appears.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: 'First Name', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: _lastNameController, decoration: const InputDecoration(labelText: 'Last Name', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()), keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 12),
              TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: _confirmPasswordController, obscureText: true, decoration: const InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(controller: _roleController, decoration: const InputDecoration(labelText: 'Role (e.g., User)', border: OutlineInputBorder())),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
