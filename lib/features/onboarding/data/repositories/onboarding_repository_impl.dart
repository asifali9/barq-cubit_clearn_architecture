import 'package:untitled1/features/onboarding/data/data_source/onboard_local_data_source.dart';
import 'package:untitled1/features/onboarding/domain/entities/user_entity.dart';
import 'package:untitled1/features/onboarding/domain/repositories/OnboardingRepository.dart';

import '../data_source/onboard_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingDataSource _dataSource;
  final OnboardingLocalDataSource _localDataSource;

  OnboardingRepositoryImpl(this._dataSource, this._localDataSource);

  @override
  Future<void> verifyPhoneNumber(String phone) async {
    _dataSource.registerPhone(phone);
  }

  @override
  Future<UserEntity> verifyOtp(String phone, String otp) {
    return _dataSource.verifyOtp(otp, phone);
  }

  @override
  Future<void> isGuestUser(bool isGuest) async {
    await _localDataSource.saveGuestMode(isGuest);
  }

  @override
  Future<void> isIntroduced(bool isIntroduced) async {
    await _localDataSource.setAppIntroduced(isIntroduced);
  }

  @override
  Future<bool> checkIfAppIntroduced() {
    return _localDataSource.checkIfAppIntroduced();
  }
}
