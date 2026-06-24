import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../routes/route_names.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_page_indicator.dart';

/// Three swipeable slides shown after splash, before authentication.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  bool get _isLastSlide => _currentIndex == onboardingSlides.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNext() {
    if (_isLastSlide) {
      _finishOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _finishOnboarding() {
    // TODO(Step 8): persist "onboarding_seen" via LocalStorageService so
    // returning users skip straight past this next launch.
    context.go(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24, top: 8),
                child: TextButton(
                  onPressed: _isLastSlide ? null : _finishOnboarding,
                  child: Text(
                    AppStrings.skip,
                    style: AppTextStyles.bodyMedium()
                        .copyWith(color: AppColors.textSecondaryLight),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingSlides.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) =>
                    _OnboardingSlideView(slide: onboardingSlides[index]),
              ),
            ),
            OnboardingPageIndicator(
              count: onboardingSlides.length,
              currentIndex: _currentIndex,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomButton(
                label: _isLastSlide ? AppStrings.getStarted : AppStrings.next,
                onPressed: _goToNext,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlideView extends StatelessWidget {
  final OnboardingSlideData slide;

  const _OnboardingSlideView({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              slide.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Shown until the real illustration file exists at this
                // path — keeps the screen usable in the meantime.
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    border: Border.all(color: AppColors.borderLight),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Icon(Icons.image_outlined,
                        size: 64, color: AppColors.textSecondaryLight),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          Text(slide.title, textAlign: TextAlign.center, style: AppTextStyles.h2()),
          const SizedBox(height: 12),
          Text(
            slide.subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.secondary(fontSize: 16),
          ),
        ],
      ),
    );
  }
}