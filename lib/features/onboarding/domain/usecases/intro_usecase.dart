import 'package:untitled1/features/onboarding/domain/repositories/onboarding_repository.dart';

class IntroUsecase {

  OnboardingRepository repository;
  IntroUsecase({required this.repository});

  void execute(bool isIntroduced){
    repository.isIntroduced(isIntroduced);
  }

  Future<bool> isAppIntroduced(){
    return repository.checkIfAppIntroduced();
  }
}