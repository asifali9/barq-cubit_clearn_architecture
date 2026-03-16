import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'intro_screen.dart';
import 'mobile_screen.dart';
import 'onboarding_cubit.dart';
import 'onboarding_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Now this works! BlocProvider is above MaterialApp in main.dart
      if (mounted) {
        context.read<OnboardingCubit>().checkIfAppIntroduced();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        final Widget? destination = switch (state) {
          OnboardingIntroduced() => const MobileScreen(),
          OnboardingInitial()    => const IntroScreen(),
          _                      => null,
        };

        if (destination != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => destination),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: [
              PhysicalModel(
                color: Colors.white,
                shape: BoxShape.circle,
                child: Image.asset(
                  'assets/ic_barq_logo.png',
                  width: 120,
                  height: 120,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
