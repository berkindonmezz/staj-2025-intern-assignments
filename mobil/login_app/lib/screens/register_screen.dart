import 'package:flutter/material.dart';
import 'package:login_app/services/auth_service.dart';
import 'package:login_app/widgets/auth_page_layout.dart';
import 'package:login_app/widgets/custom_auth_button.dart';
import 'package:login_app/widgets/custom_textfield.dart';

/// A screen that provides a user interface for new user registration.
/// It is built using reusable widgets for a clean and maintainable structure.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _roleController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  /// Handles the registration process.
  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    setState(() { _isLoading = true; });
    try {
      await _authService.register(
        username: _usernameController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        role: _roleController.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful! Please sign in.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

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
    // The entire page layout is managed by the AuthPageLayout widget.
    return AuthPageLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Header Section ---
          const Text(
            'Create Account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3D3D3D),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Enter your details to start',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5A5A5A),
            ),
          ),
          const SizedBox(height: 30),

          // --- Input Fields (using custom widgets) ---
          CustomTextField(controller: _firstNameController, hintText: 'First Name', icon: Icons.person_outline),
          const SizedBox(height: 16),
          CustomTextField(controller: _lastNameController, hintText: 'Last Name', icon: Icons.person_outline),
          const SizedBox(height: 16),
          CustomTextField(controller: _usernameController, hintText: 'Username', icon: Icons.account_circle_outlined),
          const SizedBox(height: 16),
          CustomTextField(controller: _emailController, hintText: 'Email', icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 16),
          CustomTextField(controller: _passwordController, hintText: 'Password', icon: Icons.lock_open_outlined, obscureText: true),
          const SizedBox(height: 16),
          CustomTextField(controller: _confirmPasswordController, hintText: 'Confirm Password', icon: Icons.lock_outline, obscureText: true),
          const SizedBox(height: 16),
          CustomTextField(controller: _roleController, hintText: 'Role (e.g., User)', icon: Icons.verified_user_outlined),
          const SizedBox(height: 30),

          // --- Register Button (using custom widget) ---
          CustomAuthButton(
            label: 'Sign Up',
            isLoading: _isLoading,
            onPressed: _register,
            backgroundColor: const Color(0xFF5f4b8b),
            foregroundColor: Colors.white,
          ),
          const SizedBox(height: 16),

          // --- Login Link ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(color: Color(0xFF5A5A5A)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Color(0xFF5f4b8b),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
