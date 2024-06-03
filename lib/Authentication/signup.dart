import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/Authentication/auth_services.dart';
import 'package:gym/Authentication/email_verification.dart';
import 'package:gym/Authentication/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController userNameController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();

bool _isLoading = false;

class _SignupScreenState extends State<SignupScreen> {
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();
  }
  void signUpUser(BuildContext context) async {
    // Check for empty fields and profile photo
    if (userNameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        // confirmPasswordController.text.isEmpty ||
        emailController.text.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("Oops, Something's Missing!"),
          content: const Text(
            " Make sure to fill out all fields and add your profile photo, please.",
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("Got it, will do!"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );

      return;
    }
    setState(() {
      _isLoading = true;
    });

    String res = await AuthServices().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      // Add this line
      userName: userNameController.text, // Add this line
    );
    setState(() {
      _isLoading = false;
    });

    if (res == 'Success') {
      // Show snackbar with success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign up successful!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to verification page
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) =>
              EmailVerificationPage(email: emailController.text),
        ),
      ).then((value) {
        // Refresh verification page after user clicks on verification link
        setState(() {});
        // Navigate to home screen if user's email is verified
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      });
    } else {
      // Show snackbar with error message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(res),
          // ignore: use_build_context_synchronously
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 24, color: CupertinoColors.white),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Now begin the fitness journey',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          color: CupertinoColors.systemGrey),
                    ),
                  ),
                ],
              ),
              TextField(
                  controller: userNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      label: Text('Username'), border: OutlineInputBorder())),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      label: Text('Email'), border: OutlineInputBorder())),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: passwordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      label: Text('Password'), border: OutlineInputBorder())),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: confirmPasswordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      label: Text('Confirm password'),
                      border: OutlineInputBorder())),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                color: CupertinoColors.activeGreen,
                borderRadius: BorderRadius.circular(30),
                onPressed: () => signUpUser(context),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: CupertinoColors.black),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already a Fit-Freak Account',
                    style: TextStyle(color: CupertinoColors.systemGrey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
