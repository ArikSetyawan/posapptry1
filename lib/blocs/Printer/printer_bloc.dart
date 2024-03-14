import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:equatable/equatable.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  PrinterBloc() : super(PrinterInitial()) {
    on<GetPrinterDevices>((event, emit) async {
      emit(PrinterLoading());
      try {
        BlueThermalPrinter blueThermalPrinter = BlueThermalPrinter.instance;
        List<BluetoothDevice> devices = await blueThermalPrinter.getBondedDevices();
        emit(PrinterLoaded(devices: devices));
      } catch (e) {
        emit(PrinterError(message: e.toString()));
      }
    });

    on<PrintUsingThisDevice>((event, emit) async {
      emit(PrinterLoading());
      try {
        BlueThermalPrinter blueThermalPrinter = BlueThermalPrinter.instance;
        await blueThermalPrinter.connect(event.device);
        if ((await blueThermalPrinter.isConnected)!) {
          await blueThermalPrinter.printNewLine();
          await blueThermalPrinter.printCustom('Invoice',1,1);
          await blueThermalPrinter.printNewLine();
          await blueThermalPrinter.printCustom('Nama : Client1',0,0);
          await blueThermalPrinter.printCustom('Alamat : Wakanda Utara',0,0);
          await blueThermalPrinter.printNewLine();
          await blueThermalPrinter.printCustom('Test1 @1 45.591',0,0);
          await blueThermalPrinter.printCustom('Test1 @1 45.591',0,0);
          await blueThermalPrinter.printCustom('Test1 @1 45.591',0,0);
          await blueThermalPrinter.printNewLine();
          await blueThermalPrinter.printCustom('Grand Total : Rp.45.591',0,0);
          await blueThermalPrinter.printNewLine();
          await blueThermalPrinter.printNewLine();
          await blueThermalPrinter.paperCut();
          await blueThermalPrinter.disconnect();
          emit(PrinterPrintingSuccess());
        } else {
          emit(const PrinterError(message: "Failed to Connect to Device"));
        }
      } catch (e) {
        emit(PrinterError(message: e.toString()));
      }
    });
  }
}
