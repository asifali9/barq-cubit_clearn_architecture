import 'package:untitled1/features/onboarding/domain/entities/user_entity.dart';

abstract class OnboardingRepository{
  Future<void> isIntroduced(bool isIntroduced);
  Future<void> isGuestUser(bool isGuest);
  Future<void> verifyPhoneNumber(String phoneNum);
  Future<UserEntity> verifyOtp(String phone,String otp);

  Future<bool> checkIfAppIntroduced();
}