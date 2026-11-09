import 'dart:async';
import 'dart:io';

class ReachabilityChecker {
  const ReachabilityChecker({
    this.host = _defaultHost,
    this.timeout = _defaultTimeout,
  });

  static const String _defaultHost = 'example.com';
  static const Duration _defaultTimeout = Duration(seconds: 2);

  final String host;
  final Duration timeout;

  Future<bool> isReachable() async {
    try {
      final addresses = await InternetAddress.lookup(host).timeout(timeout);
      return addresses.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }
}
