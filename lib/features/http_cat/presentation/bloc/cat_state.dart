import '../../domain/entities/cat_status.dart';

class CatState {
  final bool isLoading;
  final String? errorMessage;
  final CatStatus? currentCat;
  final List<CatStatus> favorites;

  const CatState({
    required this.isLoading,
    required this.errorMessage,
    required this.currentCat,
    required this.favorites,
  });

  const CatState.initial()
      : isLoading = false,
        errorMessage = null,
        currentCat = null,
        favorites = const [];

  bool get hasCurrentCat => currentCat != null;

  bool get isCurrentCatFavorite {
    final cat = currentCat;
    if (cat == null) return false;
    return favorites.any((item) => item.statusCode == cat.statusCode);
  }

  CatState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
    CatStatus? currentCat,
    bool clearCurrentCat = false,
    List<CatStatus>? favorites,
  }) {
    return CatState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      currentCat: clearCurrentCat ? null : (currentCat ?? this.currentCat),
      favorites: favorites ?? this.favorites,
    );
  }
}
