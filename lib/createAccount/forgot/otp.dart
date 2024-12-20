import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';
import 'dart:async';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  List<String> otpCode = ['', '', '', ''];
  int _resendCodeTimer = 45; // Timer for resend code
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  void startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCodeTimer > 0) {
        setState(() {
          _resendCodeTimer--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleOtpInput(int index, String value) {
    setState(() {
      otpCode[index] = value;
      if (value.isNotEmpty && index < 3) {
        // Move focus to the next field
        FocusScope.of(context).nextFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: screenSize.height * 0.022,
            left: screenSize.width * 0.06,
            right: screenSize.width * 0.05,
            bottom: screenSize.height * 0.022),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'OTP Code Verification',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: screenSize.width * 0.01),
                        const Icon(Icons.verified_outlined,
                            color: blue, size: 30),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'We have sent an OTP to your email i********@ymail.com,\nEnter the OTP code below to verify',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: screenSize.height * 0.046),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return Container(
                          width: screenSize.height * 0.07,
                          height: screenSize.height * 0.07,
                          decoration: BoxDecoration(
                            border: Border.all(color: blue, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            onChanged: (value) {
                              _handleOtpInput(index, value);
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: screenSize.height * 0.09),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Didn't receive email?",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.04),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Code has been resent'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text(
                          'Resend code',
                          style: TextStyle(fontSize: 14, color: blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, newPassword);
              },
              child: Container(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.05,
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text('Continue',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
