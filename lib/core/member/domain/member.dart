import 'package:equatable/equatable.dart';

final class Member extends Equatable {
  const Member({
    required this.id,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.photo,
    required this.totalPoints,
    required this.notificationCount,
  });

  final int id;
  final String phone;
  final String firstName;
  final String? lastName;
  final DateTime dateOfBirth;
  final String? photo;
  final int totalPoints;
  final int notificationCount;

  String get fullName {
    final surname = lastName;
    if (surname == null || surname.isEmpty) return firstName;
    return '$firstName $surname';
  }

  @override
  List<Object?> get props => [
    id,
    phone,
    firstName,
    lastName,
    dateOfBirth,
    photo,
    totalPoints,
    notificationCount,
  ];
}
