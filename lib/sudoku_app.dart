import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sudoku/controllers/settings_notifier.dart';
import 'package:sudoku/entities/settings.dart';
import 'package:sudoku/l10n/app_localizations.dart';
import 'package:sudoku/pages/home_page.dart';

class SudokuApp extends ConsumerWidget {
  const SudokuApp({super.key, this.initialSaved});

  final Map<String, dynamic>? initialSaved;

  ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF4F46E5),
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Avant d'avoir chargé les settings, on tombe sur les defaults — ça évite
    // un flicker de thème au boot. Le rebuild se fera dès que l'AsyncNotifier
    // a fini son load (quelques ms avec SharedPreferences).
    final settings = ref.watch(settingsNotifierProvider).valueOrNull ??
        const Settings();

    return MaterialApp(
      title: 'Sudoku',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: settings.theme.themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomePage(initialSaved: initialSaved),
    );
  }
}
