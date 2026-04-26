import '../../domain/entities/cat_status.dart';

abstract class CatEvent {}

class LoadCatByStatusCode extends CatEvent {
  final int statusCode;

  LoadCatByStatusCode(this.statusCode);
}

class ToggleCurrentCatFavorite extends CatEvent {}

class LoadFavorites extends CatEvent {}

class ToggleFavoriteByValue extends CatEvent {
  final CatStatus catStatus;

  ToggleFavoriteByValue(this.catStatus);
}
