// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/main.dart';
import 'package:gym/screens/home.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;

  const EmailVerificationPage({Key? key, required this.email})
      : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  late User currentUser;

  // ignore: prefer_typing_uninitialized_variables

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!;
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
        child: FutureBuilder(
          future:
              FirebaseAuth.instance.currentUser!.reload(), // add reload() here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (FirebaseAuth.instance.currentUser!.emailVerified) {
                return const HomePage();
              } else {
                var email = widget.email;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'We have sent an email to your account ${email} \nPlease click the verification link in the email to verify your account.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CupertinoButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.currentUser!
                            .reload(); // add reload() here
                        if (FirebaseAuth.instance.currentUser!.emailVerified) {
                          // Restart the app
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            runApp(
                              MyApp(), // Replace MyApp() with your main widget's name
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                "Email not verified yet",
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
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
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
