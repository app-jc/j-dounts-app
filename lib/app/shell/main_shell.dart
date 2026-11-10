import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:j_dounts_app/core/network/connectivity_service.dart';
import 'package:j_dounts_app/core/widgets/offline_banner.dart';

import 'package:j_dounts_app/app/shell/sliding_nav_bar.dart';

class MainShell extends StatelessWidget {
  const MainShell({
    required this.navigationShell,
    super.key,
    this.isOffline = false,
    this.connectivityService,
  });

  final StatefulNavigationShell navigationShell;
  final bool isOffline;
  final ConnectivityService? connectivityService;

  @override
  Widget build(BuildContext context) {
    final service = connectivityService;
    final content = (service == null)
        ? _shellBody(context, isOffline)
        : StreamBuilder<bool>(
            stream: service.watchOffline(),
            initialData: isOffline,
            builder: (context, snapshot) =>
                _shellBody(context, snapshot.data ?? isOffline),
          );
    return content;
  }

  Widget _shellBody(BuildContext context, bool offline) => Scaffold(
    body: Column(
      children: [
        OfflineBanner(visible: offline),
        Expanded(child: navigationShell),
      ],
    ),
    bottomNavigationBar: SlidingNavBar(
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: navigationShell.goBranch,
    ),
  );
}
