import 'dart:async';
import 'package:uuid/uuid.dart';
import '../../../models/user_model.dart';

/// Defines the auth contract. Screens/providers depend on this interface
/// only — swap MockAuthRepository for a real Firebase/REST implementation
/// later without touching any UI code.
abstract class AuthRepository {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
  });
  Future<void> forgotPassword({required String email});
}

/// Simulated backend with artificial network delay and basic validation,
/// so the UI behaves exactly as it will against a real API later.
class MockAuthRepository implements AuthRepository {
  static const _networkDelay = Duration(milliseconds: 900);
  final Uuid _uuid = const Uuid();

  @override
  Future<UserModel> login({required String email, required String password}) async {
    await Future.delayed(_networkDelay);

    if (!_isValidEmail(email)) {
      throw const AuthException('Please enter a valid email address.');
    }
    if (password.length < 6) {
      throw const AuthException('Password must be at least 6 characters.');
    }

    // Mock: any well-formed email/password combination succeeds.
    return UserModel(
      id: _uuid.v4(),
      fullName: email.split('@').first,
      email: email,
    );
  }

  @override
  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await Future.delayed(_networkDelay);

    if (fullName.trim().isEmpty) {
      throw const AuthException('Please enter your full name.');
    }
    if (!_isValidEmail(email)) {
      throw const AuthException('Please enter a valid email address.');
    }
    if (password.length < 6) {
      throw const AuthException('Password must be at least 6 characters.');
    }

    return UserModel(
      id: _uuid.v4(),
      fullName: fullName.trim(),
      email: email,
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await Future.delayed(_networkDelay);

    if (!_isValidEmail(email)) {
      throw const AuthException('Please enter a valid email address.');
    }
    // Mock: pretend a reset email was sent.
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email);
  }
}

/// Thrown on validation/auth failure. Typed (not a raw String) so the
/// provider layer can distinguish expected auth errors from real bugs.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}