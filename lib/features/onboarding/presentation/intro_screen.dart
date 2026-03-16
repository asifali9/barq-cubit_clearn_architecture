import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/core/constants/app_colors.dart';
import 'package:untitled1/features/dashboard/presentation/dashboard_cubit.dart';

import 'mobile_screen.dart';
import 'onboarding_cubit.dart';
// import 'package:untitled1/features/presentation/mobile_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _pageController;
  int _currentIndex = 0;
  final int _totalSteps = 4;

  bool lastPagescrolled = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_currentIndex < _totalSteps - 1) {
          _currentIndex++;
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
          _animationController.reset();
          _animationController.forward();
        }else
          {
            setState(() {
              lastPagescrolled = true;
            });
          }
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (innercontext) {
        if(lastPagescrolled)
          {
            innercontext.read<OnboardingCubit>().setAppIntroduced(true);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MobileScreen()));
          }
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).size.height * 0.43,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                      _animationController.reset();
                      _animationController.forward();
                    });
                  },
                  children: [
                    pagerContent(
                      imagePath: 'assets/maps.png',
                      backgroundColor: AppColors.x,
                    ),
                    pagerContent(
                      imagePath: 'assets/maps.png',
                      backgroundColor: AppColors.x,
                    ),
                    pagerContent(
                      imagePath: 'assets/man_holding_key.png',
                      backgroundColor: AppColors.y,
                    ),
                    pagerContent(
                      imagePath: 'assets/horse.png',
                      backgroundColor: AppColors.z,
                    ),
                  ],
                ),
              ),
              // Lower portion: Content card with rounded corners
              Positioned(
                top: MediaQuery.of(context).size.height * 0.48,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.transparent,
                    //     blurRadius: 0,
                    //     offset: Offset(0, -75),
                    //   ),
                    // ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Material(
                    color: Colors.transparent,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'SAR ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const Text(
                                          '1,250.50',
                                          style: TextStyle(
                                            fontSize: 32,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Add more content here as needed
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Progress Indicator
              Positioned(
                top: 40,
                left: 15,
                right: 15,
                child: Row(
                  children: List.generate(_totalSteps, (index) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: LinearProgressIndicator(
                          value: _getStepProgress(index),
                          backgroundColor: Colors.black12,
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                          minHeight: 4,
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _getStepProgress(int index) {
    if (index < _currentIndex) {
      return 1.0;
    } else if (index == _currentIndex) {
      return _animationController.value;
    } else {
      return 0.0;
    }
  }
}

Widget pagerContent({
  required String imagePath,
  required Color backgroundColor,
}) {
  return Container(
    padding: const EdgeInsets.only(top: 50),
    // alignment: Alignment.bottomCenter,
    width: double.infinity,
    height: double.infinity,
    color: backgroundColor,
    child: Image.asset(imagePath, fit: BoxFit.contain),
  );
}
