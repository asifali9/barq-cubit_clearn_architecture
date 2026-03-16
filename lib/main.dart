import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/core/local_storage/app_preferences.dart';
import 'package:untitled1/core/network/dio_client.dart';
import 'package:untitled1/features/onboarding/data/data_source/onboard_data_source_impl.dart';
import 'package:untitled1/features/onboarding/data/data_source/onboard_local_data_source_impl.dart';
import 'package:untitled1/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:untitled1/features/onboarding/domain/usecases/intro_usecase.dart';
import 'package:untitled1/features/onboarding/domain/usecases/mobile_usecase.dart';
import 'package:untitled1/features/onboarding/domain/usecases/otp_usecase.dart';
import 'package:untitled1/features/onboarding/presentation/onboarding_cubit.dart';
import 'package:untitled1/features/onboarding/presentation/splash_screen.dart';

late final AppPreferences appPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  appPrefs = AppPreferences(prefs);

  // Build the dependency chain ONCE here
  final dioClient = DioClient();
  final remoteSource = OnboardDataSourceImpl(api: dioClient);
  final localSource = OnboardingLocalDataSourceImpl(appPrefs);
  final repoImpl = OnboardingRepositoryImpl(remoteSource, localSource);

  runApp(
    // BlocProvider is ABOVE MaterialApp → all routes can access OnboardingCubit!
    BlocProvider(
      create: (_) => OnboardingCubit(
        registerPhoneUseCase: MobileUsecase(repository: repoImpl),
        verifyOtpUseCase: OtpUsecase(repository: repoImpl),
        introUsecase: IntroUsecase(repository: repoImpl),
      ),
      child: const MaterialApp(
        home: SplashScreen(),
      ),
    ),
  );
}
