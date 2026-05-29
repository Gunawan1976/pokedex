part of 'root_bloc.dart';

abstract class RootEvent extends Equatable {
  const RootEvent();

  @override
  List<Object?> get props => [];
}

class ShowSnackBarEvent extends RootEvent {
  final String message;
  const ShowSnackBarEvent(this.message);
}
