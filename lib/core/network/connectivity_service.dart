import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:j_dounts_app/core/network/reachability_checker.dart';

abstract interface class ConnectivityService {
  Future<bool> isOffline();

  Stream<bool> watchOffline();
}

class ConnectivityServiceImpl implements ConnectivityService {
  ConnectivityServiceImpl({
    Connectivity? connectivity,
    ReachabilityChecker? reachabilityChecker,
  }) : _connectivity = connectivity ?? Connectivity(),
       _reachabilityChecker =
           reachabilityChecker ?? const ReachabilityChecker();

  final Connectivity _connectivity;
  final ReachabilityChecker _reachabilityChecker;

  @override
  Future<bool> isOffline() async {
    final results = await _connectivity.checkConnectivity();
    return _isOffline(results);
  }

  @override
  Stream<bool> watchOffline() async* {
    yield await isOffline();
    yield* _connectivity.onConnectivityChanged.asyncMap(_isOffline);
  }

  Future<bool> _isOffline(List<ConnectivityResult> results) async {
    if (results.every((result) => result == ConnectivityResult.none)) {
      return true;
    }
    return !(await _reachabilityChecker.isReachable());
  }
}
