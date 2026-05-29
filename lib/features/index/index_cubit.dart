
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(const IndexState(0));

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(const IndexState(0));
        break;
      case 1:
        emit(const IndexState(1));
        break;
    }
  }
}