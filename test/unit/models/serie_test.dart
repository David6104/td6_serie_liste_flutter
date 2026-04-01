import 'package:flutter_test/flutter_test.dart';
import 'package:serie_liste/models/serie.dart';

void main() {
  group('Serie', () {
    // JSON complet tel que retourné par l'API TVMaze
    final jsonComplet = {
      'id': 1,
      'name': 'Breaking Bad',
      'genres': ['Drama', 'Crime'],
      'status': 'Ended',
      'image': {'medium': 'https://example.com/bb.jpg'},
      'summary': '<p>Un professeur de chimie…</p>',
      'rating': {'average': 9.5},
    };

    test('fromJson crée une Serie correctement', () {
      final serie = Serie.fromJson(jsonComplet);

      // TODO : vérifier que serie.id vaut 1
      // TODO : vérifier que serie.nom vaut 'Breaking Bad'
      // TODO : vérifier que serie.genre vaut 'Drama' (premier élément de genres)
      // TODO : vérifier que serie.statut vaut 'Ended'
      // TODO : vérifier que serie.note vaut 9.5
      // TODO : vérifier que serie.imageUrl vaut 'https://example.com/bb.jpg'
    });

    test('fromJson supprime les balises HTML du synopsis', () {
      final serie = Serie.fromJson(jsonComplet);

      // TODO : vérifier que serie.synopsis vaut 'Un professeur de chimie…'
      // TODO : vérifier que serie.synopsis ne contient pas la chaîne '<p>'
      //        (indice : expect(..., isNot(contains(...))))
    });

    test('fromJson gère les champs optionnels absents', () {
      final jsonMinimal = {'id': 2, 'name': 'Test'};
      final serie = Serie.fromJson(jsonMinimal);

      // TODO : vérifier que serie.imageUrl est null
      // TODO : vérifier que serie.note est null
      // TODO : vérifier que serie.genre vaut 'Inconnu'
      // TODO : vérifier que serie.synopsis vaut ''
    });

    test('toJson / fromJson sont symétriques', () {
      final original = Serie.fromJson(jsonComplet);

      // TODO : appeler Serie.fromJson sur original.toJson() pour reconstruire une série
      // TODO : vérifier que la série reconstruite a le même id que original
      // TODO : vérifier que la série reconstruite a le même nom que original
      // TODO : vérifier que la série reconstruite a la même note que original
    });
  });
}
