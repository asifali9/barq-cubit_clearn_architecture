
import 'package:untitled1/core/network/dio_client.dart';
import 'package:untitled1/features/onboarding/data/data_source/onboard_data_source.dart';
import 'package:untitled1/features/onboarding/data/models/user_model.dart';

class OnboardDataSourceImpl implements OnboardingDataSource {
  final DioClient api;
  
  OnboardDataSourceImpl({required this.api});

  @override
  Future<UserModel> verifyOtp(String otp, String phone) async {
    var response = await api.post('path',data: {
      'otp':otp,
      'phone':phone
    });
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> registerPhone(String phone) async {
    await api.post('registerphone',data: {
      'phone':phone
    });
  }
}