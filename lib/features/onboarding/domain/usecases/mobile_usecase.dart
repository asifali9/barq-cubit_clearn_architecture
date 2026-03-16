import 'package:untitled1/features/onboarding/domain/repositories/onboarding_repository.dart';

class MobileUsecase {

  OnboardingRepository repository;
  MobileUsecase({required this.repository});

  Future<void> execute(String phone) async {
    await repository.verifyPhoneNumber(phone);
  }
}