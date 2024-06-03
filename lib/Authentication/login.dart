import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/Authentication/auth_services.dart';
import 'package:gym/Authentication/forgot_password.dart';
import 'package:gym/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();



class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await AuthServices().loginUser(
          email: emailController.text, password: passwordController.text);

      if (res == 'Success') {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (context) => const HomePage()));
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
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
                      'Log In',
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

              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      label: Text('Email'), border: OutlineInputBorder())),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      label: Text('Password'), border: OutlineInputBorder())),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const ForgotPassword()));
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: CupertinoColors.systemGrey),
                    ),
                  ),
                ],
              ),
              // TextField(
              //     controller: confirmPasswordController,
              //     decoration: const InputDecoration(
              //         label: Text('Confirm password'),
              //         border: OutlineInputBorder())),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                color: CupertinoColors.activeGreen,
                borderRadius: BorderRadius.circular(30),
               onPressed: isLoading ? null : login,
                child: const Text(
                  'Login',
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
                    'New to FitFreak',
                    style: TextStyle(color: CupertinoColors.systemGrey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Sign Up',
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
