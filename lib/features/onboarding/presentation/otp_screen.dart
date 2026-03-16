import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:untitled1/core/components/Images.dart';
import 'package:untitled1/core/components/Texts.dart';
import 'package:untitled1/core/constants/app_colors.dart';
import 'package:untitled1/core/constants/app_strings.dart';

import '../../dashboard/presentation/home_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 55,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: AppColors.otp_box,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppAssetImage(
                        imagePath: 'assets/ic_close.png',
                        width: 44,
                        height: 44,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            AppAssetImage(
              imagePath: 'assets/ic_otp.png',
              width: 100,
              height: 100,
            ),
            AppText(text: AppStrings.enter_otp_title),
            AppText(
              text: "${AppStrings.otp_sent_to} ${widget.phoneNumber}",
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 50),
            Pinput(
              length: 4,
              controller: _pinController,
              focusNode: _focusNode,showCursor: false,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: Colors.transparent),
                ),
              ),
              onCompleted: (pin) {
                // Logic when OTP is fully entered
                print("Entered PIN: $pin");
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            const SizedBox(height: 100),
            AppText(
              text: AppStrings.otp_not_received_title,
              textColor: AppColors.text_gray,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            AppText(
              text: AppStrings.resend_otp_,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
