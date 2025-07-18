import 'package:filtrek_app/core/app/router_config.dart';
import 'package:filtrek_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final container = ProviderScope.containerOf(context, listen: false);

    return MaterialApp.router(
      routerConfig: container.read(routeConfigProvider),
      debugShowCheckedModeBanner: false,
      title: 'Filtrek',
      theme: AppTheme.darkTheme,
    );
  }
}
