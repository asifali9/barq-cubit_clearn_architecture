import 'package:untitled1/features/onboarding/domain/entities/user_entity.dart';
import 'package:untitled1/features/onboarding/domain/repositories/onboarding_repository.dart';

class OtpUsecase {
  final OnboardingRepository repository;

  OtpUsecase({required this.repository});

  Future<UserEntity> execute(String phone, String otp) async {
    return await repository.verifyOtp(phone, otp);
  }
}