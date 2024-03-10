part of 'cash_drawer_bloc.dart';

sealed class CashDrawerEvent extends Equatable {
  const CashDrawerEvent();

  @override
  List<Object> get props => [];
}

class OpenCashDrawer extends CashDrawerEvent {}

class PrintUsingInternalDevice extends CashDrawerEvent {
  final StarXpandPrinter device;

  const PrintUsingInternalDevice({required this.device});
  @override
  List<Object> get props => [device];
}