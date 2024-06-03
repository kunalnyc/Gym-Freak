import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/Authentication/signup.dart';

class PageSlides extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final CupertinoButton tap;
  const PageSlides(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.tap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropShadowImage(
            offset: const Offset(10,10),
            image: Image.asset(image),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 20),
            child: Text(
              title,
              style: const TextStyle(
                color: CupertinoColors.activeGreen,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          //Description
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 20),
                child: Text(
                  description,
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
              color: CupertinoColors.activeGreen,
              child: const Text('Next'),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const SignupScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
