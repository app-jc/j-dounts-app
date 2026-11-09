import 'package:equatable/equatable.dart';

/// Represents the identity of an authenticated user.
final class AuthIdentity extends Equatable {
  const AuthIdentity({required this.memberId});

  final int memberId;

  @override
  List<Object?> get props => [memberId];
}
