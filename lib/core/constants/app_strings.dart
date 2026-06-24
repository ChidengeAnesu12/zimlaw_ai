/// Centralized copy for onboarding/splash.
/// Keeping these as named constants (not inline strings) means when we
/// build real Shona/Ndebele localization later, these become lookup keys
/// instead of scattered hardcoded text across screens.
class AppStrings {
  AppStrings._();

  // Splash
  static const String appName = 'ZimLaw AI';
  static const String splashHeadline = 'Know Your Rights. Protect Your Future.';
  static const String getStarted = 'Get Started';
  static const String login = 'Login';

  // Onboarding slides
  static const String onboardingTitle1 = 'Know Your Rights';
  static const String onboardingSubtitle1 = 'Access Zimbabwean legal information instantly.';

  static const String onboardingTitle2 = 'Research Smarter';
  static const String onboardingSubtitle2 = 'Search laws, cases and legal precedents.';

  static const String onboardingTitle3 = 'Protect Your Property';
  static const String onboardingSubtitle3 = 'Verify documents and resolve land disputes.';

  static const String skip = 'Skip';
  static const String next = 'Next';
}