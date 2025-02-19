import 'package:flutter/material.dart';
import 'package:test/screens/home.dart';
import '../services/auth_service.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String verificationId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Authentication")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Enter phone number"),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthService().sendOTP(phoneController.text, (id) {
                  setState(() {
                    verificationId = id;
                  });
                });
              },
              child: Text("Send OTP"),
            ),
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: "Enter OTP"),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                 bool isVerified = await AuthService().verifyOTP(verificationId, otpController.text);
                if (isVerified) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()), // Navigate to HomePage
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invalid OTP, please try again")),
                  );
                }
              },
              child: Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
