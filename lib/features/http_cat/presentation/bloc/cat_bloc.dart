import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_cat_by_status_code.dart';
import '../../domain/usecases/get_favorite_cats.dart';
import '../../domain/usecases/toggle_favorite_cat.dart';
import 'cat_event.dart';
import 'cat_state.dart';

/// Presentation layer BLoC coordinating UI events with domain use cases.
class CatBloc extends Bloc<CatEvent, CatState> {
  final GetCatByStatusCode _getCatByStatusCode;
  final GetFavoriteCats _getFavoriteCats;
  final ToggleFavoriteCat _toggleFavoriteCat;

  CatBloc(
    this._getCatByStatusCode,
    this._getFavoriteCats,
    this._toggleFavoriteCat,
  ) : super(const CatState.initial()) {
    on<LoadCatByStatusCode>(_onLoadCatByStatusCode);
    on<ToggleCurrentCatFavorite>(_onToggleCurrentCatFavorite);
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavoriteByValue>(_onToggleFavoriteByValue);
  }

  Future<void> _onLoadCatByStatusCode(
    LoadCatByStatusCode event,
    Emitter<CatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearErrorMessage: true));

    try {
      final cat = await _getCatByStatusCode(event.statusCode);
      emit(state.copyWith(isLoading: false, currentCat: cat));
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onToggleCurrentCatFavorite(
    ToggleCurrentCatFavorite event,
    Emitter<CatState> emit,
  ) async {
    final currentCat = state.currentCat;
    if (currentCat == null) return;

    final updatedFavorites = await _toggleFavoriteCat(currentCat);
    emit(state.copyWith(favorites: updatedFavorites, clearErrorMessage: true));
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<CatState> emit,
  ) async {
    final favorites = await _getFavoriteCats();
    emit(state.copyWith(favorites: favorites));
  }

  Future<void> _onToggleFavoriteByValue(
    ToggleFavoriteByValue event,
    Emitter<CatState> emit,
  ) async {
    final updatedFavorites = await _toggleFavoriteCat(event.catStatus);
    emit(state.copyWith(favorites: updatedFavorites, clearErrorMessage: true));
  }
}
