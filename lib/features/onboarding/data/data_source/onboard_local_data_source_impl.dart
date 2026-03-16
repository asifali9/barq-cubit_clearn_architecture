import 'package:untitled1/core/local_storage/app_preferences.dart';
import 'package:untitled1/features/onboarding/data/data_source/onboard_local_data_source.dart';

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final AppPreferences preferences;

  OnboardingLocalDataSourceImpl(this.preferences);

  @override
  Future<void> setAppIntroduced(bool isIntroduced) async {
    await preferences.saveIsAppIntroduced(isIntroduced);
  }

  @override
  Future<void> saveToken(String token) async {
    await preferences.saveToken(token);
  }

  @override
  Future<void> saveGuestMode(bool isGuest) async {
    await preferences.saveIsGuest(isGuest);
  }

  @override
  Future<bool> checkIfAppIntroduced() async {
    return preferences.getIsAppIntroduced();
  }
}