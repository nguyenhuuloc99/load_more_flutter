import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/ApiService.dart';
import 'bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  ApiService apiService = ApiService();

  CommentBloc() : super(CommentLoading()) {
    on<FetchEvent>((event, emit) => _fetchData(event, emit));
    on<RefreshEvent>((event, emit) => _refreshData(event, emit));
  }

  Future _fetchData(FetchEvent event, Emitter<CommentState> emit) async {
    if (!(state is CommentSuccess && (state as CommentSuccess).hasReachedEnd)) {
      try {
        if (state is CommentLoading) {
          emit(CommentLoading());
          var response = await apiService.getCommentsFromApi(0, 20);
          emit(CommentSuccess(listComment: response, hasReachedEnd: false));
        } else if (state is CommentSuccess) {
          final currentState = state as CommentSuccess;
          int finalIndexOfCurrentPage = currentState.listComment.length;
          var response =
              await apiService.getCommentsFromApi(finalIndexOfCurrentPage, 20);
          emit(CommentSuccess(listComment: response, hasReachedEnd: false));
          if (response.isEmpty) {
            emit(currentState.cloneWith(hasReachedEnd: true));
          } else {
            emit(currentState.cloneWith(
                list: currentState.listComment + response,
                hasReachedEnd: false));
          }
        }
      } catch (e) {}
    }
  }

  Future _refreshData(RefreshEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    var response =
    await apiService.getCommentsFromApi(0, 20);
    emit(CommentSuccess(listComment: response, hasReachedEnd: false));
  }
}
