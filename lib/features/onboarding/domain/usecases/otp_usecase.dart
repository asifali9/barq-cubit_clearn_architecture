import 'package:untitled1/features/onboarding/domain/entities/user_entity.dart';
import 'package:untitled1/features/onboarding/domain/repositories/OnboardingRepository.dart';

class OtpUsecase {
  final OnboardingRepository repository;

  OtpUsecase({required this.repository});

  Future<UserEntity> execute(String Phone, String otp) async {
    return await repository.verifyOtp(Phone, otp);
  }
}