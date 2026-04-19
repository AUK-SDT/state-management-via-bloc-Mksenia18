import '../models/cat.dart';

abstract class CatState {}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final Cat cat;

  CatLoaded(this.cat);
}

class CatError extends CatState {
  final String message;

  CatError(this.message);
}
