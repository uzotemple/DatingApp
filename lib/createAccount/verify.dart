import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/create_account_provider.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:love_bird/providers/otp_provider.dart';
import 'package:love_bird/providers/resend_provider.dart';
import 'package:provider/provider.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  List<String> otpCode = ['', '', '', '', '', ''];

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

  void _submitOtp() {
    final otpProvider =
        Provider.of<OtpVerificationProvider>(context, listen: false);
    final accountProvider =
        Provider.of<CreateAccountProvider>(context, listen: false);

    final otp = otpCode.join(); // Combine the OTP parts into one string
    final userId = accountProvider.userId;

    if (otp.length == 6 && userId != null) {
      otpProvider.verifyOtp(context, otp, userId);
    } else if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('User ID is missing. Please go back to Sign up Pge.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
    }
  }

  void _resendOtp() {
    final accountProvider =
        Provider.of<CreateAccountProvider>(context, listen: false);
    final resendOtp = Provider.of<ResendProvider>(context, listen: false);

    final userId = accountProvider.userId;

    if (userId != null) {
      resendOtp.resendverifyOtp(context, userId);
    } else if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('User ID is missing. Please go back to Sign up Pge.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occured')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<OtpVerificationProvider>(context);
    final accountProvider =
        Provider.of<CreateAccountProvider>(context, listen: false);

    final userId = accountProvider.userId;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Email Verification',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.verified_outlined, color: blue, size: 24),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'We have sent an OTP to your email ,\nEnter the OTP code below to verify your Email',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.109,
                          height: MediaQuery.of(context).size.height * 0.07,
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
                              setState(() {
                                otpCode[index] = value;
                                if (value.isNotEmpty && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                }
                              });
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        // Logic for resending code
                        onTap: () {
                          Navigator.pushNamed(context, captchaVerificationPage);
                        },
                        child: const Text(
                          "Didn't receive email?",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          developer.log('Response status: $userId');
                          _resendOtp();
                        },
                        child: const Text(
                          'Resend code ',
                          style: TextStyle(fontSize: 14, color: blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            otpProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _submitOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Verify OTP',
                        style: TextStyle(color: Colors.white)),
                  ),
          ],
        ),
      ),
    );
  }
}
