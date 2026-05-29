part of 'root_bloc.dart';

class RootState extends Equatable {
  final String? snackbarMessage;
  final int snackbarId; // unique trigger

  const RootState({
    this.snackbarMessage,
    required this.snackbarId,
  });

  factory RootState.initial() {
    return const RootState(
      snackbarMessage: null,
      snackbarId: 0,
    );
  }

  RootState copyWith({
    String? snackbarMessage,
    int? snackbarId,
  }) {
    return RootState(
      snackbarMessage: snackbarMessage,
      snackbarId: snackbarId ?? this.snackbarId,
    );
  }

  @override
  List<Object?> get props => [snackbarMessage, snackbarId];
}