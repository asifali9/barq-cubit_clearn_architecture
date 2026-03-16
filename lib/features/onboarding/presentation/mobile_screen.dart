import 'package:flutter/material.dart';
import 'package:untitled1/core/components/images.dart';
import 'package:untitled1/core/components/texts.dart';
import 'package:untitled1/core/components/text_fields.dart';
import 'package:untitled1/core/components/buttons.dart';
import 'package:untitled1/core/constants/app_colors.dart';
import 'package:untitled1/core/constants/app_strings.dart';
import 'package:untitled1/core/components/bottom_sheets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_cubit.dart';
import 'onboarding_state.dart';
import 'otp_screen.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedOperatorImage;
  final String _selectedCountryFlag = "🇸🇦";
  final String _selectedCountryCode = "+966";

  @override
  Widget build(BuildContext context) {
    // We inject the entire logic chain here.
    // In a real app with 'get_it', this would just be: create: (context) => getIt<OnboardingCubit>()
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 100),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/ic_barq_logo.png", width: 100, height: 100),
                AppText(text: AppStrings.welcomeToBarqTitle),
                AppText(
                  text: AppStrings.enterMobileTitle,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: _phoneNumberController,
                  hintText: "5X XXX XXXX",
                  textLength: 10,
                  prefixIcon: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        showAppModalSheet(
                          context,
                          content: AppModalSheet(
                            title: "Select Operator",
                            children: [
                              _buildOperatorItem("Jazz", "assets/ic_jazz.png"),
                              const SizedBox(height: 10),
                              _buildOperatorItem("Zong", "assets/ic_zong.png"),
                              const SizedBox(height: 10),
                              _buildOperatorItem("Telenor", "assets/ic_telenor.png"),
                              const SizedBox(height: 10),
                              _buildOperatorItem("Ufone", "assets/ic_ufone.png"),
                            ],
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_selectedOperatorImage != null)
                              AppAssetImage(imagePath: _selectedOperatorImage!, width: 24)
                            else
                              Text(_selectedCountryFlag, style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 4),
                            AppText(
                              text: _selectedCountryCode,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            const Icon(Icons.arrow_drop_down, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (validation) {
                    if (validation == null || validation.isEmpty) {
                      return "Please enter your mobile number";
                    } else if (validation.length != 10) {
                      return "Invalid phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                AppText(
                  text: AppStrings.agreeToContinue,
                  fontSize: 13,
                  textColor: AppColors.textGray,
                  fontWeight: FontWeight.w400,
                ),

                AppText(
                  text: AppStrings.termsPolicy,
                  fontSize: 13,
                  textColor: AppColors.textGray,
                  fontWeight: FontWeight.w400,
                ),
                const Text.rich(TextSpan(children: [])),

                const SizedBox(height: 24),

                // Wrap just the button in BlocConsumer
                BlocConsumer<OnboardingCubit, OnboardingState>(
                  listener: (context, state) {
                    if (state is OnboardingCodeSent) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber: _phoneNumberController.text)),
                      );
                    } else if (state is OnboardingFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      text: AppStrings.titleContinue,
                      isLoading: state is OnboardingLoading, // Show spinner!
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<OnboardingCubit>().submitPhoneNumber(_phoneNumberController.text);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOperatorItem(String name, String imagePath) {
    return Material(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      child: ListTile(
        onTap: () {
          setState(() {
            _selectedOperatorImage = imagePath;
          });
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: AppAssetImage(
          imagePath: imagePath,
          width: 24,
        ),
        title: AppText(
          text: name,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
