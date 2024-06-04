// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gym/screens/home.dart'; 

class EmailVerificationPage extends StatefulWidget {
  final String email;

  const EmailVerificationPage({Key? key, required this.email}) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  late User currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!;
    _checkEmailVerification();
  }

  Future<void> _checkEmailVerification() async {
    await currentUser.reload();
    if (currentUser.emailVerified) {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'Verify Your Email',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'We have sent an email to your account ${widget.email} \nPlease click the verification link in the email to verify your account.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : CupertinoButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      await currentUser.reload();
                      if (currentUser.emailVerified) {
                        _navigateToHome();
                      } else {
                        setState(() {
                          _isLoading = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Email not verified yet"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                          ),
                        );
                      }
                    },
                    color: Theme.of(context).brightness == Brightness.dark
                        ? CupertinoColors.black
                        : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(30),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30,
                    ),
                    child: Text(
                      'Check verification',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
