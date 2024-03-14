part of 'printer_bloc.dart';

sealed class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object> get props => [];
}

class GetPrinterDevices extends PrinterEvent {}

class PrintUsingThisDevice extends PrinterEvent {
  final BluetoothDevice device;

  const PrintUsingThisDevice({required this.device});
  @override
  List<Object> get props => [device];
  
}