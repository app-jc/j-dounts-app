import 'package:equatable/equatable.dart';

final class AuthIdentity extends Equatable {
  const AuthIdentity({required this.memberId});

  final int memberId;

  @override
  List<Object?> get props => [memberId];
}
