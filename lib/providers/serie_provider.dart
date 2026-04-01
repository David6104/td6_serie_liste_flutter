import 'package:flutter/material.dart';
import '../models/serie.dart';
import '../services/serie_api_service.dart';

class SerieProvider with ChangeNotifier {
  // Pour l'instant, le service est créé directement ici — c'est suffisant
  // pour les étapes 3 à 7. L'étape 8 montrera comment le rendreremplaçable.
  final SerieApiService _apiService = SerieApiService();
  List<Serie> _series = [];
  bool _isLoading = false;
  String? _error;
  List<Serie> get series => _series;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Future<void> fetchSeries() async {
    _isLoading = true;
    _error = null;
    try {
      _series = await _apiService.fetchSeries();
    } catch (e) {
      _error = 'Impossible de charger les séries.';
      _series = _apiService.getMockSeries();
    } finally {
      _isLoading = false;
      // fetchSeries() est async : quand on arrive ici, le build estterminé.
      // notifyListeners() peut donc être appelé directement.
      notifyListeners();
    }
  }

  Future<Serie> fetchSerieById(int id) async {
    return _apiService.fetchSerieById(id);
  }
}
