import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../routes/route_names.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authNotifierProvider.notifier).login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

    if (success && mounted) context.go(RouteNames.home);
  }

  void _showComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google/Apple sign-in coming soon — use email for now.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.screenPaddingH,
            vertical: AppSizes.lg,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.xl),
                Text('Welcome Back', style: AppTextStyles.h1()),
                const SizedBox(height: 8),
                Text('Log in to continue accessing legal help.',
                    style: AppTextStyles.secondary(fontSize: 16)),
                const SizedBox(height: AppSizes.xl),
                CustomTextField(
                  label: 'Email',
                  hint: 'you@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.mail_outline,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Email is required' : null,
                ),
                const SizedBox(height: AppSizes.md),
                CustomTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) =>
                      (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(RouteNames.forgotPassword),
                    child: const Text('Forgot Password?'),
                  ),
                ),
                if (authState.errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(authState.errorMessage!,
                      style: AppTextStyles.bodySmall().copyWith(color: AppColors.error)),
                ],
                const SizedBox(height: AppSizes.md),
                CustomButton(
                  label: 'Login',
                  isLoading: authState.isLoading,
                  onPressed: _handleLogin,
                ),
                const SizedBox(height: AppSizes.lg),
                _buildDivider(),
                const SizedBox(height: AppSizes.lg),
                CustomButton(
                  label: 'Continue with Google',
                  isOutlined: true,
                  icon: Icons.g_mobiledata,
                  onPressed: _showComingSoon,
                ),
                const SizedBox(height: AppSizes.sm),
                CustomButton(
                  label: 'Continue with Apple',
                  isOutlined: true,
                  icon: Icons.apple,
                  onPressed: _showComingSoon,
                ),
                const SizedBox(height: AppSizes.xl),
                Center(
                  child: GestureDetector(
                    onTap: () => context.push(RouteNames.register),
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodyMedium(),
                        children: [
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: 'Register',
                            style: AppTextStyles.bodyMedium()
                                .copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.borderLight)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('or continue with', style: AppTextStyles.bodySmall()),
        ),
        const Expanded(child: Divider(color: AppColors.borderLight)),
      ],
    );
  }
}