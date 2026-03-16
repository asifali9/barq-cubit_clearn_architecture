import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:untitled1/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:untitled1/features/onboarding/domain/usecases/intro_usecase.dart';
import 'package:untitled1/features/onboarding/domain/usecases/mobile_usecase.dart';
import 'package:untitled1/features/onboarding/domain/usecases/otp_usecase.dart';
import 'package:untitled1/features/onboarding/presentation/onboarding_cubit.dart';
import 'package:untitled1/features/onboarding/presentation/onboarding_state.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late MockOnboardingRepository mockRepo;
  late OnboardingCubit cubit;
  setUp(() {
    mockRepo = MockOnboardingRepository();
    cubit = OnboardingCubit(
      introUsecase: IntroUsecase(repository: mockRepo),
      registerPhoneUseCase: MobileUsecase(repository: mockRepo),
      verifyOtpUseCase: OtpUsecase(repository: mockRepo),
    );
  });

  tearDown(() => cubit.close());

  group('phonesubmission', () {
    blocTest<OnboardingCubit, OnboardingState>(
        'emit [loading,phoneotp] states when phone number is added',
        setUp: () {
          when(() => mockRepo.verifyPhoneNumber('123456789'))
              .thenAnswer((_) async {});
        }, build: () => cubit,
        act: (cubit) => cubit.submitPhoneNumber('123456789'),
        expect: () =>
          [isA<OnboardingLoading>(), isA<OnboardingCodeSent>(),]

    );
  });
}

