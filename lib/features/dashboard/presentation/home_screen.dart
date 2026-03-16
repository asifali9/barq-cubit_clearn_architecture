import 'package:flutter/material.dart';
import 'package:untitled1/core/components/Images.dart';
import 'package:untitled1/core/components/Texts.dart';
import 'package:untitled1/core/components/buttons.dart';
import 'package:untitled1/core/constants/app_strings.dart';

import '../../../core/components/app_dialogs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAutomaticDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text('Home Screen'))),
    );
  }

  void _showAutomaticDialog() {
    appDialog(
      context: context,
      children: Column(
        children: [
          AppAssetImage(
            imagePath: 'assets/ic_wheel.png',
            width: 150,
            height: 150,
          ),
          AppText(text: AppStrings.spin_wheel_title),
          AppText(text: AppStrings.spin_and_win_title),
        ],
      ),
      actions: CustomButton(
        text: AppStrings.title_spin,
        onPressed: () {
          Navigator.pop(context);
        },
        width: double.infinity,
        height: 48,
      ),
    );
  }
}
