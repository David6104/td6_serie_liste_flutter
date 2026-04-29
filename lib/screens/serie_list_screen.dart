import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/serie_provider.dart';

class SerieListScreen extends StatefulWidget {
  const SerieListScreen({super.key});

  @override
  State<SerieListScreen> createState() => _SerieListScreenState();
}

class _SerieListScreenState extends State<SerieListScreen> {
  @override
  void initState() {
    super.initState();
    // Déclenche le chargement après la construction du premier frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SerieProvider>().fetchSeries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SérieListe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.go('/favoris'),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => context.go('/watchlist'),
          ),
        ],
      ),
      body: Consumer<SerieProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }
          return ListView.builder(
            itemCount: provider.series.length,
            itemBuilder: (context, index) {
              final serie = provider.series[index];
              return ListTile(
                leading: serie.imageUrl != null
                    ? Image.network(serie.imageUrl!,
                        width: 50, fit: BoxFit.cover)
                    : const Icon(Icons.tv),
                title: Text(serie.nom),
                subtitle: Text('${serie.genre} · ${serie.statut}'),
                trailing: serie.note != null
                    ? Text('★ ${serie.note!.toStringAsFixed(1)}')
                    : null,
                onTap: () => context.go('/serie/${serie.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
