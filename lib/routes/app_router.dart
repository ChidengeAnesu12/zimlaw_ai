import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../features/onboarding/presentation/screens/splash_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';

/// TEMPORARY placeholder for Home — replaced with the real dashboard next.
class _HomePlaceholderScreen extends StatelessWidget {
  const _HomePlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home dashboard — coming next', style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: RouteNames.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: RouteNames.onboarding, builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: RouteNames.login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: RouteNames.register, builder: (context, state) => const RegisterScreen()),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: RouteNames.home, builder: (context, state) => const _HomePlaceholderScreen()),
    ],
  );
}