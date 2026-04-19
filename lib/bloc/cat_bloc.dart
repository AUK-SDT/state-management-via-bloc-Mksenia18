import 'package:flutter_bloc/flutter_bloc.dart';
import 'cat_event.dart';
import 'cat_state.dart';
import '../services/api_service.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final ApiService apiService;

  CatBloc(this.apiService) : super(CatInitial()) {
    on<FetchCatEvent>(_onFetchCat);
  }

  Future<void> _onFetchCat(FetchCatEvent event, Emitter<CatState> emit) async {
    emit(CatLoading());

    try {
      final cat = await apiService.fetchCat(event.code);
      emit(CatLoaded(cat));
    } catch (e) {
      emit(CatError(e.toString()));
    }
  }
}
