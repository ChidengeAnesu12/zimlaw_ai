import 'package:equatable/equatable.dart';

enum UserRole {
  citizen,
  lawyer,
  lawStudent,
  propertyOwner,
  realEstateProfessional,
  governmentOfficer,
}

/// Core user model shared across auth, profile, and anywhere user data
/// is displayed. Extends Equatable so Riverpod/widgets can compare
/// instances by value instead of by reference.
class UserModel extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String? photoUrl;
  final UserRole role;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.photoUrl,
    this.role = UserRole.citizen,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? photoUrl,
    UserRole? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [id, fullName, email, photoUrl, role];
}