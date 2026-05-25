import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'repositories/game_repository.dart';
import 'l10n/app_localizations.dart';
import 'controllers/settings_controller.dart';
import 'controllers/stats_controller.dart';
import 'pages/home_page.dart';

class SudokuApp extends StatelessWidget {
  const SudokuApp({
    super.key,
    required this.repository,
    required this.statsController,
    required this.settingsController,
    this.initialSaved,
  });

  final GameRepository repository;
  final StatsController statsController;
  final SettingsController settingsController;
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
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StatsController>.value(value: statsController),
        ChangeNotifierProvider<SettingsController>.value(value: settingsController),
      ],
      child: Consumer<SettingsController>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Sudoku',
            debugShowCheckedModeBanner: false,
            theme: _buildTheme(Brightness.light),
            darkTheme: _buildTheme(Brightness.dark),
            themeMode: settings.settings.theme.themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: HomePage(
              repository: repository,
              initialSaved: initialSaved,
            ),
          );
        },
      ),
    );
  }
}
