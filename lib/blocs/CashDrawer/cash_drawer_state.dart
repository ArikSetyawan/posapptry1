part of 'cash_drawer_bloc.dart';

sealed class CashDrawerState extends Equatable {
  const CashDrawerState();
  
  @override
  List<Object> get props => [];
}

final class CashDrawerInitial extends CashDrawerState {}

final class CashDrawerLoading extends CashDrawerState {}

final class CashDrawerOpened extends CashDrawerState {
  final List<StarXpandPrinter> devices;

  const CashDrawerOpened({required this.devices});
}

final class CashDrawerError extends CashDrawerState {
  final String message;

  const CashDrawerError({required this.message});
  @override
  List<Object> get props => [message];
}
