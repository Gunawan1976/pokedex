import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc() : super(RootState.initial()) {
    on<ShowSnackBarEvent>((event, emit) {
      emit(
        state.copyWith(
          snackbarMessage: event.message,
          snackbarId: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    });
  }
}
