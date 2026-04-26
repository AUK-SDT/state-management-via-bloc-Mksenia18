import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/http_cat/data/datasources/favorites_local_data_source.dart';
import 'features/http_cat/data/datasources/http_cat_remote_data_source.dart';
import 'features/http_cat/data/repositories/cat_repository_impl.dart';
import 'features/http_cat/domain/usecases/get_cat_by_status_code.dart';
import 'features/http_cat/domain/usecases/get_favorite_cats.dart';
import 'features/http_cat/domain/usecases/toggle_favorite_cat.dart';
import 'features/http_cat/presentation/bloc/cat_bloc.dart';
import 'features/http_cat/presentation/bloc/cat_event.dart';
import 'features/http_cat/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = HttpCatRemoteDataSource();
    final favoritesDataSource = FavoritesLocalDataSource();
    final repository = CatRepositoryImpl(remoteDataSource, favoritesDataSource);

    return BlocProvider(
      create: (_) => CatBloc(
        GetCatByStatusCode(repository),
        GetFavoriteCats(repository),
        ToggleFavoriteCat(repository),
      )..add(LoadFavorites()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.orange,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
