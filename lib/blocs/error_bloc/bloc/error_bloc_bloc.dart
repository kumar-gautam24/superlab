import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'error_bloc_event.dart';
part 'error_bloc_state.dart';

class ErrorBlocBloc extends Bloc<ErrorBlocEvent, ErrorBlocState> {
  ErrorBlocBloc() : super(ErrorBlocInitial()) {
    on<ErrorBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
