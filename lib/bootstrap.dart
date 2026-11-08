import 'package:flutter/widgets.dart';

import 'package:j_dounts_app/app/app.dart';
import 'package:j_dounts_app/app/di/injection.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const App());
}
