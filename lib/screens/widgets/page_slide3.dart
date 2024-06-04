import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageSlides3 extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final CupertinoButton tap;
  const PageSlides3(
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
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.5), // Adjust color and opacity as needed
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(0, 2), // Shadow offset
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), // Adjust border radius as needed
              child: Image.asset(
                image, // Replace with your image path
                width: 200, // Adjust width as needed
                height: 200, // Adjust height as needed
                fit: BoxFit.cover,
              ),
            ),
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: CupertinoButton(
          //     color: CupertinoColors.activeGreen,
          //     child: const Text('Next'),
          //     onPressed: () {
          //       Navigator.of(context).push(CupertinoPageRoute(
          //           builder: (context) => const SignupScreen()));
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
