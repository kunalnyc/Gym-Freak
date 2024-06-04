import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/Authentication/signup.dart';
import 'package:gym/screens/page_slides.dart';
import 'package:gym/screens/widgets/page_slide2.dart';
import 'package:gym/screens/widgets/page_slide3.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

int _currentPage = 0;

class _WelcomePageState extends State<WelcomePage> {
  // ignore: unused_field
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              // Page slides Start From Here
              //Page 1
              const PageSlides3(
                image: 'assets/slide1.png',
                title: 'Welcome to the FitFreak',
                description:
                    'Your fitness journey starts now\n      Get active & stay healthy',
                tap: CupertinoButton(
                  onPressed: null,
                  child: Text('Next'),
                ),
              ),
              const PageSlides2(
                image: 'assets/slide3.png',
                title: 'Excercise Library',
                description:
                    'Build Workout, Select excercises \n set weights & reps',
                tap: CupertinoButton(
                  onPressed: null,
                  child: Text('Next'),
                ),
              ),
              PageSlides(
                image: 'assets/slide2.png',
                title: 'Tracking Progress',
                description: 'Monitor your achivements and\n stay motivated',
                tap: CupertinoButton(
                  color: CupertinoColors.activeGreen,
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.animateToPage(
                        _currentPage + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => const SignupScreen(),
                      ));
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildDot(int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    width: _currentPage == index ? 10 : 8,
    height: 16,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: _currentPage == index ? CupertinoColors.activeGreen : Colors.grey,
    ),
  );
}
