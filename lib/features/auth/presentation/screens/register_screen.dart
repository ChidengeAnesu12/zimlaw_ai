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

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authNotifierProvider.notifier).register(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

    if (success && mounted) context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(backgroundColor: AppColors.backgroundLight, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create Account', style: AppTextStyles.h1()),
                const SizedBox(height: 8),
                Text('Join ZimLaw AI to access legal help, research, and more.',
                    style: AppTextStyles.secondary(fontSize: 16)),
                const SizedBox(height: AppSizes.xl),
                CustomTextField(
                  label: 'Full Name',
                  hint: 'Tinashe Moyo',
                  controller: _nameController,
                  prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Full name is required' : null,
                ),
                const SizedBox(height: AppSizes.md),
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
                  hint: 'At least 6 characters',
                  controller: _passwordController,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) =>
                      (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: AppSizes.md),
                CustomTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  controller: _confirmPasswordController,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) => v != _passwordController.text ? 'Passwords do not match' : null,
                ),
                if (authState.errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(authState.errorMessage!,
                      style: AppTextStyles.bodySmall().copyWith(color: AppColors.error)),
                ],
                const SizedBox(height: AppSizes.lg),
                CustomButton(
                  label: 'Create Account',
                  isLoading: authState.isLoading,
                  onPressed: _handleRegister,
                ),
                const SizedBox(height: AppSizes.lg),
                Center(
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodyMedium(),
                        children: [
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Login',
                            style: AppTextStyles.bodyMedium()
                                .copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}