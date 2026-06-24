import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';

/// Static content for a single onboarding slide.
@immutable
class OnboardingSlideData {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnboardingSlideData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

/// The 3 onboarding slides, in display order, per spec.
const List<OnboardingSlideData> onboardingSlides = [
  OnboardingSlideData(
    title: AppStrings.onboardingTitle1,
    subtitle: AppStrings.onboardingSubtitle1,
    imagePath: AppAssets.onboardingRights,
  ),
  OnboardingSlideData(
    title: AppStrings.onboardingTitle2,
    subtitle: AppStrings.onboardingSubtitle2,
    imagePath: AppAssets.onboardingResearch,
  ),
  OnboardingSlideData(
    title: AppStrings.onboardingTitle3,
    subtitle: AppStrings.onboardingSubtitle3,
    imagePath: AppAssets.onboardingProperty,
  ),
];