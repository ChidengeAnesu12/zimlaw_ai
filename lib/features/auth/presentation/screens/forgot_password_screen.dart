import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../providers/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref
        .read(authNotifierProvider.notifier)
        .forgotPassword(email: _emailController.text.trim());

    if (success && mounted) setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(backgroundColor: AppColors.backgroundLight, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: _submitted ? _buildSuccessView() : _buildFormView(authState),
        ),
      ),
    );
  }

  Widget _buildFormView(AuthState authState) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Forgot Password?', style: AppTextStyles.h1()),
          const SizedBox(height: 8),
          Text("Enter your email and we'll send you a link to reset your password.",
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
          if (authState.errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(authState.errorMessage!,
                style: AppTextStyles.bodySmall().copyWith(color: AppColors.error)),
          ],
          const SizedBox(height: AppSizes.lg),
          CustomButton(
            label: 'Send Reset Link',
            isLoading: authState.isLoading,
            onPressed: _handleSubmit,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.mark_email_read_outlined, size: 64, color: AppColors.primary),
        const SizedBox(height: AppSizes.lg),
        Text('Check Your Email', textAlign: TextAlign.center, style: AppTextStyles.h2()),
        const SizedBox(height: 8),
        Text(
          'If an account exists for that email, a reset link is on its way.',
          textAlign: TextAlign.center,
          style: AppTextStyles.secondary(fontSize: 16),
        ),
        const SizedBox(height: AppSizes.xl),
        CustomButton(label: 'Back to Login', onPressed: () => context.pop()),
      ],
    );
  }
}