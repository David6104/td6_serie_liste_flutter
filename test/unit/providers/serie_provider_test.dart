import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serie_liste/providers/serie_provider.dart';

// Pour tester SerieProvider de façon isolée, nous allons observer
// son comportement via ses getters publics.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('SerieProvider', () {
    test('état initial : liste vide, pas de chargement', () {
      final provider = SerieProvider();
      expect(provider.series, isEmpty);
      expect(provider.isLoading, isFalse);
      expect(provider.error, isNull);
    });
    test('notifie les listeners quand fetchSeries est appelé', () async {
      final provider = SerieProvider();
      var notified = false;
      provider.addListener(() => notified = true);
      // fetchSeries tente un vrai appel réseau ici — il tombera en erreur
      // mais notifiera quand même (fallback mock).
      await provider.fetchSeries();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(notified, isTrue);
    });
  });
}
