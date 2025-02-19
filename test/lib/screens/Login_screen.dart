import 'package:flutter/material.dart';
import 'package:test/screens/phone_auth.dart';
import 'package:test/screens/signup.dart';
import '../services/auth_service.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signup(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign in',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _emailAddress(),
              const SizedBox(height: 16),
              _password(),
              const SizedBox(height: 16),
              _signin(context),
              const SizedBox(height: 16),
              _facebookLogin(context),
              const SizedBox(height: 16),
              _phoneLogin(context), // 📌 Added Phone Login Button
            ],
          ),
        ),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Do not have an account?'),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
          child: const Text('Sign up'),
        ),
      ],
    );
  }

  Widget _emailAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email address'),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            hintText: 'Enter your email address',
          ),
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password'),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Enter your password',
          ),
        ),
      ],
    );
  }

  Widget _signin(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await AuthService().signin(
          email: _emailController.text,
          password: _passwordController.text,
          context: context,
        );
      },
      child: const Text('Sign in'),
    );
  }

  Widget _facebookLogin(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      onPressed: () async {
        await AuthService().signInWithFacebook(context);
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.facebook, color: Colors.white),
          SizedBox(width: 8),
          Text('Continue with Facebook', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  // 📌 New Phone Login Button
  Widget _phoneLogin(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PhoneAuthScreen()), // Navigate to PhoneLogin screen
        );
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.phone, color: Colors.white),
          SizedBox(width: 8),
          Text('Sign in with Phone', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
