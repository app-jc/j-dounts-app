import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:j_dounts_app/core/error/result.dart';
import 'package:j_dounts_app/features/home/domain/home_data.dart';
import 'package:j_dounts_app/features/home/domain/home_repository.dart';
import 'package:j_dounts_app/features/home/presentation/home_state.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeStarted extends HomeEvent {
  const HomeStarted();
}

final class HomeRefreshRequested extends HomeEvent {
  const HomeRefreshRequested();
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._repository, {required this.memberId})
    : super(const HomeInitial()) {
    on<HomeStarted>(_onStarted, transformer: restartable());
    on<HomeRefreshRequested>(_onRefresh, transformer: droppable());
  }

  final HomeRepository _repository;
  final int memberId;

  HomeData? get _previous => switch (state) {
    HomeLoaded(:final data) => data,
    HomeLoading(:final previous) => previous,
    HomeFailure(:final previous) => previous,
    HomeInitial() => null,
  };

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(HomeLoading(previous: _previous));
    await emit.forEach<Result<HomeData>>(
      _repository.watchHome(memberId),
      onData: (result) => result.fold(
        onFailure: (failure) => HomeFailure(failure, previous: _previous),
        onSuccess: _loaded,
      ),
      onError: (error, stackTrace) =>
          HomeFailure(UnexpectedFailure(cause: error), previous: _previous),
    );
  }

  HomeLoaded _loaded(HomeData data) => HomeLoaded(
    data: data,
    sectionStates: {
      for (final section in data.sections)
        section.id: section.products.isEmpty
            ? HomeSectionEmpty(section)
            : HomeSectionLoaded(section),
    },
  );

  void _onRefresh(HomeRefreshRequested event, Emitter<HomeState> emit) {}
}
