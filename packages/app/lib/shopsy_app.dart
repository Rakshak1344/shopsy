import 'package:app/navigation/app_router.dart';
import 'package:core/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShopsyApp extends ConsumerStatefulWidget {
  const ShopsyApp({super.key});

  @override
  ConsumerState createState() => _ShopsyAppState();
}

class _ShopsyAppState extends ConsumerState<ShopsyApp> {
  @override
  Widget build(BuildContext context) {
    var goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Shopsy',
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      routerConfig: goRouter,
    );
  }
}
