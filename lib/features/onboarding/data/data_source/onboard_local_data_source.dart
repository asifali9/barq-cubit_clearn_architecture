
abstract class OnboardingLocalDataSource {
  Future<void> setAppIntroduced(bool isIntroduced);
  Future<bool> checkIfAppIntroduced();
  Future<void> saveToken(String token);
  Future<void> saveGuestMode(bool isGuest);
}