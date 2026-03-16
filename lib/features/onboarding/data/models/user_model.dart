import 'package:untitled1/features/onboarding/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.mobileNumber,super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      mobileNumber: json['mobile_number'],
      token: json['auth_token'],
    );
  }
  }