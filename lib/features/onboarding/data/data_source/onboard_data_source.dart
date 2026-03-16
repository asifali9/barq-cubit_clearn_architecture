
import 'package:untitled1/features/onboarding/domain/entities/user_entity.dart';

abstract class OnboardingDataSource {
  Future<void> registerPhone(String phone);
  Future<UserEntity> verifyOtp(String otp,String phone);
}