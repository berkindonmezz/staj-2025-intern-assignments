import 'package:flutter/material.dart';
import 'package:login_app/screens/display_token_screen.dart';
import 'package:login_app/widgets/auth_page_layout.dart';
import 'package:login_app/widgets/custom_auth_button.dart';
import 'package:login_app/widgets/custom_textfield.dart';

/// A screen where users can request a password reset token by providing their email.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  /// Handles the request to send a password reset token.
  Future<void> _sendResetToken() async {
    setState(() { _isLoading = true; });

    // TODO: Add AuthService call here to request the token from the backend.
    // For now, we simulate a network call and navigate to the next screen with a dummy token.
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const DisplayTokenScreen(
          resetToken: 'ed52dc83e94248a8', // This will come from the API
        ),
      ));
    }

    setState(() { _isLoading = false; });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Header Section ---
          const Text(
            'Reset your password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3D3D3D),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Enter your email address',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF5A5A5A),
            ),
          ),
          const SizedBox(height: 40),

          // --- Input Field ---
          CustomTextField(
            controller: _emailController,
            hintText: 'Email Address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 30),

          // --- Button ---
          CustomAuthButton(
            label: 'Send Reset Token',
            isLoading: _isLoading,
            onPressed: _sendResetToken,
            backgroundColor: const Color(0xFF5f4b8b),
            foregroundColor: Colors.white,
          ),
          const SizedBox(height: 20),

          // --- Back to Login Link ---
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Remember your password? Sign In',
              style: TextStyle(
                color: Color(0xFF5f4b8b),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
