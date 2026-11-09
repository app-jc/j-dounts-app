import 'package:equatable/equatable.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/home/domain/home_data.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object?> get props => [];
}

final class HomeLoading extends HomeState {
  const HomeLoading({this.previous});

  final HomeData? previous;

  @override
  List<Object?> get props => [previous];
}

final class HomeLoaded extends HomeState {
  HomeLoaded({
    required this.data,
    required Map<String, HomeSectionState> sectionStates,
    this.isOffline = false,
  }) : sectionStates = Map.unmodifiable(sectionStates);

  final HomeData data;
  final Map<String, HomeSectionState> sectionStates;
  final bool isOffline;

  @override
  List<Object?> get props => [data, sectionStates, isOffline];
}

final class HomeFailure extends HomeState {
  const HomeFailure(this.failure, {this.previous});

  final Failure failure;
  final HomeData? previous;

  @override
  List<Object?> get props => [failure, previous];
}

sealed class HomeSectionState extends Equatable {
  const HomeSectionState();
}

final class HomeSectionLoading extends HomeSectionState {
  const HomeSectionLoading();

  @override
  List<Object?> get props => [];
}

final class HomeSectionLoaded extends HomeSectionState {
  const HomeSectionLoaded(this.section);

  final HomeSection section;

  @override
  List<Object?> get props => [section];
}

final class HomeSectionEmpty extends HomeSectionState {
  const HomeSectionEmpty(this.section);

  final HomeSection section;

  @override
  List<Object?> get props => [section];
}

final class HomeSectionError extends HomeSectionState {
  const HomeSectionError(this.failure, {this.section});

  final Failure failure;
  final HomeSection? section;

  @override
  List<Object?> get props => [failure, section];
}

final class HomeSectionOffline extends HomeSectionState {
  const HomeSectionOffline({this.cachedSection});

  final HomeSection? cachedSection;

  @override
  List<Object?> get props => [cachedSection];
}
