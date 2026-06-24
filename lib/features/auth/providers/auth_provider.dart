import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model.dart';
import '../data/mock_auth_repository.dart';

/// Drives loading spinners and inline error messages on auth screens.
/// Note: omitting `errorMessage` in copyWith() clears it (not preserves
/// it) — intentional, so a fresh attempt always starts free of stale
/// errors from the previous one.
class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final UserModel? user;

  const AuthState({this.isLoading = false, this.errorMessage, this.user});

  AuthState copyWith({bool? isLoading, String? errorMessage, UserModel? user}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      user: user ?? this.user,
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return MockAuthRepository();
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState());

  Future<bool> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _repository.login(email: email, password: password);
      state = state.copyWith(isLoading: false, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _repository.register(
        fullName: fullName,
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.forgotPassword(email: email);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  void reset() => state = const AuthState();
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});