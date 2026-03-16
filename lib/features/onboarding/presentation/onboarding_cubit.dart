import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/features/onboarding/domain/usecases/intro_usecase.dart';
import 'package:untitled1/features/onboarding/domain/usecases/mobile_usecase.dart';
import 'package:untitled1/features/onboarding/domain/usecases/otp_usecase.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final IntroUsecase introUsecase;
  final MobileUsecase registerPhoneUseCase;
  final OtpUsecase verifyOtpUseCase;

  OnboardingCubit({
    required this.introUsecase,
    required this.registerPhoneUseCase,
    required this.verifyOtpUseCase,
  }) : super(OnboardingInitial());

  Future<void> submitPhoneNumber(String phone) async {
    emit(OnboardingLoading());
    try {
      await registerPhoneUseCase.execute(phone); // Assuming execute method exists
      emit(OnboardingCodeSent(phoneNumber: phone));
    } catch (e) {
      emit(OnboardingFailure(errorMessage: e.toString())); 
    }
  }

  Future<void> submitOtp(String phone, String otp) async {
    emit(OnboardingLoading()); 
    try {
      // Assuming execute method exists in OtpUsecase
      await verifyOtpUseCase.execute(phone, otp);
      emit(OnboardingSuccess()); 
    } catch (e) {
      emit(OnboardingFailure(errorMessage: e.toString()));
    }
  }

  void setAppIntroduced(bool isIntroduced)
  {
   introUsecase.execute(isIntroduced);
  }

  Future<void> checkIfAppIntroduced()
  async {
    var introduced = await introUsecase.isAppIntroduced();
    if(introduced) {
      emit(OnboardingIntroduced());
    }
    else {
      emit(OnboardingInitial());
    }
  }
}