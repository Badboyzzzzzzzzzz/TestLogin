import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test/main.dart';
import 'package:test/screens/home.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Signup with Email & Password
  Future<void> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyApp()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      }
      _showToast(message);
    }
  }

  // Signin with Email & Password
  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user';
      }
      _showToast(message);
    }
  }

  // Sign in with Facebook
  Future<UserCredential?> signInWithFacebook() async {
  try {
    // Trigger Facebook login
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      // Get the access token
      final AccessToken accessToken = result.accessToken!;
      
      // Create a Firebase credential
      final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);
      
      // Sign in with Firebase
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      print('Facebook login failed: ${result.message}');
      return null;
    }
  } catch (e) {
    print('Error during Facebook login: $e');
    return null;
  }
}


  // Logout
  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }

  // Helper method to show toast messages
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  Future<void> sendOTP(String phoneNumber, Function(String) onCodeSent) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-signs in for some devices
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Timeout: $verificationId");
      },
    );
  }

  Future<bool> verifyOTP(String verificationId, String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user != null;
    } catch (e) {
      print("Error verifying OTP: $e");
      return false;
    }
  }
}
