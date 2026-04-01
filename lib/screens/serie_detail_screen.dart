import 'package:flutter/material.dart';

// TODO étape 4 : implémenter l'écran de détail d'une série
class SerieDetailScreen extends StatelessWidget {
  final int serieId;
  const SerieDetailScreen({super.key, required this.serieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail')),
      body: Center(child: Text('Série $serieId — À implémenter — étape 4')),
    );
  }
}
