import 'package:flutter_test/flutter_test.dart';
import 'package:serie_liste/models/watchlist_item.dart';
import 'package:serie_liste/providers/watchlist_provider.dart';
import 'package:serie_liste/services/watchlist_database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../helpers/test_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('WatchlistProvider', () {
    late WatchlistDatabaseService dbService;

    setUp(() async {
      // Base SQLite in-memory : rapide, isolée, aucun fichier créé
      dbService = WatchlistDatabaseService(databasePath: inMemoryDatabasePath);
      await dbService.clearWatchlist();
    });

    tearDown(() async => dbService.close());

    // Helper : crée un provider qui utilise notre base de test
    WatchlistProvider makeProvider() =>
        WatchlistProvider(dbService: dbService);

    test('démarre avec une watchlist vide', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      // TODO : vérifier que provider.items est vide
      // TODO : vérifier que provider.itemCount vaut 0
      // TODO : vérifier que provider.isLoading est false
    });

    test('ajouterASerie ajoute une série à la watchlist', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      await provider.ajouterASerie(testSerie1);

      // TODO : vérifier que provider.items contient 1 élément
      // TODO : vérifier que le nom de la première série est 'Breaking Bad'
      // TODO : vérifier que le statut est StatutVisionnage.aVoir
    });

    test('ajouterASerie ne duplique pas une série déjà présente', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));

      await provider.ajouterASerie(testSerie1);
      await provider.ajouterASerie(testSerie1); // doublon ignoré

      // TODO : vérifier que provider.items contient toujours 1 élément
    });

    test('retirerSerie supprime la série de la watchlist', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));
      await provider.ajouterASerie(testSerie1);
      await provider.ajouterASerie(testSerie2);

      await provider.retirerSerie(testSerie1.id);

      // TODO : vérifier que provider.items contient 1 élément
      // TODO : vérifier que la série restante est 'Stranger Things'
    });

    test('changerStatut met à jour le statut', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));
      await provider.ajouterASerie(testSerie1);

      await provider.changerStatut(testSerie1.id, StatutVisionnage.enCours);

      // TODO : vérifier que provider.getStatut(testSerie1.id) vaut StatutVisionnage.enCours
    });

    test('estDansWatchlist retourne vrai si la série est présente', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));
      await provider.ajouterASerie(testSerie1);

      // TODO : vérifier que provider.estDansWatchlist(testSerie1.id) est true
      // TODO : vérifier que provider.estDansWatchlist(testSerie2.id) est false
    });

    test('persistance : les données survivent à une nouvelle instance', () async {
      // Première instance — ajoute une série
      final provider1 = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));
      await provider1.ajouterASerie(testSerie1);

      // Deuxième instance — même dbService, données rechargées depuis SQLite
      final provider2 = WatchlistProvider(dbService: dbService);
      await Future.delayed(const Duration(milliseconds: 50));

      // TODO : vérifier que provider2.items contient 1 élément
      // TODO : vérifier que le nom de la série est 'Breaking Bad'
    });

    test('notifie les listeners à chaque modification', () async {
      final provider = makeProvider();
      await Future.delayed(const Duration(milliseconds: 50));
      var count = 0;
      provider.addListener(() => count++);

      await provider.ajouterASerie(testSerie1);
      await provider.changerStatut(testSerie1.id, StatutVisionnage.enCours);
      await provider.retirerSerie(testSerie1.id);

      // TODO : vérifier que count vaut 3 (un notifyListeners par opération)
    });
  });
}
