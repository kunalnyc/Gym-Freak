import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController userNameController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();

class _ForgotPasswordState extends State<ForgotPassword> {
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
                      'Forgot password!',
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
                      'Let\s Revive You From This Problem',
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
              // const SizedBox(
              //   height: 20,
              // ),
              // TextField(
              //     controller: passwordController,
              //     decoration: const InputDecoration(
              //         label: Text('Password'), border: OutlineInputBorder())),
              // const SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   children: [
              //     InkWell(
              //       onTap: () {},
              //       child: const Text(
              //         'Forgot password?',
              //         style: TextStyle(color: CupertinoColors.systemGrey),
              //       ),
              //     ),
              //   ],
              // ),
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
                onPressed: () {},
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
