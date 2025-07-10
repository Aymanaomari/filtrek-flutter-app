import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_theme.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:filtrek_app/routes.dart";
void main() {
  debugPaintSizeEnabled = false;
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
    );
  }
}
