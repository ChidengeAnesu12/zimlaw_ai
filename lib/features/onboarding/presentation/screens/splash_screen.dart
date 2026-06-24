import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../routes/route_names.dart';

/// First screen on launch: logo, app name, tagline, primary/secondary CTAs,
/// and a language selector row (visual only for now — see note below).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Selection only — does not change app locale yet.
  // Real locale switching is built in the dedicated localization step,
  // once Shona/Ndebele translations exist for screens to actually use.
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: Column(
            children: [
              const Spacer(flex: 3),
              _buildLogo(),
              const SizedBox(height: AppSizes.xl),
              Text(AppStrings.appName, style: AppTextStyles.h1(isDark: true)),
              const SizedBox(height: 12),
              Text(
                AppStrings.splashHeadline,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge(isDark: true),
              ),
              const Spacer(flex: 3),
              CustomButton(
                label: AppStrings.getStarted,
                onPressed: () => context.go(RouteNames.onboarding),
              ),
              const SizedBox(height: 12),
              CustomButton(
                label: AppStrings.login,
                isOutlined: true,
                isDark: true,
                onPressed: () => context.go(RouteNames.login),
              ),
              const SizedBox(height: AppSizes.lg),
              _buildLanguageSelector(),
              const SizedBox(height: AppSizes.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 96,
      height: 96,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: const Icon(Icons.balance, size: 48, color: Colors.white),
    );
  }

  Widget _buildLanguageSelector() {
    const languages = ['English', 'Shona', 'Ndebele'];
    return Wrap(
      spacing: 16,
      children: languages.map((lang) {
        final bool isSelected = lang == _selectedLanguage;
        return GestureDetector(
          onTap: () => setState(() => _selectedLanguage = lang),
          child: Text(
            lang,
            style: AppTextStyles.bodyMedium(isDark: true).copyWith(
              color: isSelected ? AppColors.accent : AppColors.textSecondaryDark,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        );
      }).toList(),
    );
  }
}