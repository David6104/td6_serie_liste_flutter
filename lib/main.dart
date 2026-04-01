import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'router.dart';

// TODO étape 3 : importer SerieProvider
// TODO étape 5 : importer FavorisProvider
// TODO étape 8 : importer WatchlistProvider

void main() {
  // Initialisation SQLite nécessaire sur desktop (macOS, Windows, Linux)
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    MultiProvider(
      providers: [
        // TODO étape 3 : ChangeNotifierProvider(create: (_) => SerieProvider()),
        // TODO étape 5 : ChangeNotifierProvider(create: (_) => FavorisProvider()),
        // TODO étape 8 : ChangeNotifierProvider(create: (_) => WatchlistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SérieListe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
