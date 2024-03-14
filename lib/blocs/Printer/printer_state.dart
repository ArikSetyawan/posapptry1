part of 'printer_bloc.dart';

sealed class PrinterState extends Equatable {
  const PrinterState();
  
  @override
  List<Object> get props => [];
}

final class PrinterInitial extends PrinterState {}

final class PrinterLoading extends PrinterState {}

final class PrinterLoaded extends PrinterState {
  final List<BluetoothDevice> devices;

  const PrinterLoaded({required this.devices});
  @override
  List<Object> get props => [devices];
}

final class PrinterPrintingSuccess extends PrinterState{}

final class PrinterError extends PrinterState{
  final String message;

  const PrinterError({required this.message});
  @override
  List<Object> get props => [message];
}

