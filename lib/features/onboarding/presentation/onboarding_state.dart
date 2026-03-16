sealed class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingCodeSent extends OnboardingState {
  final String phoneNumber;
  OnboardingCodeSent({required this.phoneNumber});
}

class OnboardingIntroduced extends OnboardingState {}

class OnboardingSuccess extends OnboardingState {}

class OnboardingFailure extends OnboardingState {
  final String errorMessage;
  OnboardingFailure({required this.errorMessage});
}
