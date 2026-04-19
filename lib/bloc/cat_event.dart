abstract class CatEvent {}

class FetchCatEvent extends CatEvent {
  final int code;

  FetchCatEvent(this.code);
}
