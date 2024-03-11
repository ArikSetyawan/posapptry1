import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:starxpand/starxpand.dart';

part 'cash_drawer_event.dart';
part 'cash_drawer_state.dart';

class CashDrawerBloc extends Bloc<CashDrawerEvent, CashDrawerState> {
  CashDrawerBloc() : super(CashDrawerInitial()) {
    on<OpenCashDrawer>((event, emit) async {
      emit(CashDrawerLoading());
      try {
        Fluttertoast.showToast(msg: "Searching Devices", gravity: ToastGravity.TOP);
        // Get Devices
        List<StarXpandPrinter> searchDevices = await StarXpand.findPrinters(interfaces: [StarXpandInterface.usb]);
        if (searchDevices.isEmpty) {
          Fluttertoast.showToast(msg: "Device Not Detected", gravity: ToastGravity.TOP);
          emit(const CashDrawerError(message: "Device Not Detected"));
          return;
        } else {
          Fluttertoast.showToast(msg: "${searchDevices.length} Devices Detected", gravity: ToastGravity.TOP);
          for (var device in searchDevices) {
            await StarXpand.openDrawer(device);
          }
          emit(CashDrawerOpened(devices: searchDevices));
          return;
        }
      } catch (e) {
        emit(CashDrawerError(message: e.toString()));
      }
    });

    on<PrintUsingInternalDevice>((event, emit) async {
      try {
        Fluttertoast.showToast(msg: "Printing Invoice Using mPOP Devices", gravity: ToastGravity.TOP);
        StarXpandDocument invoice = StarXpandDocument();
        StarXpandDocumentPrint printLayout = StarXpandDocumentPrint();
        printLayout.actionPrintText(
          "        Star Clothing Boutique\n             123 Star Road\n           City, State 12345\n\nDate:MM/DD/YYYY          Time:HH:MM PM\n--------------------------------------\nSALE\nSKU            Description       Total\n300678566      PLAIN T-SHIRT     10.99\n300692003      BLACK DENIM       29.99\n300651148      BLUE DENIM        29.99\n300642980      STRIPED DRESS     49.99\n30063847       BLACK BOOTS       35.99\n\nSubtotal                        156.95\nTax                               0.00\n--------------------------------------\nTotal                           156.95\n--------------------------------------\n\nCharge\n156.95\nVisa XXXX-XXXX-XXXX-0123\nRefunds and Exchanges\nWithin 30 days with receipt\nAnd tags attached\n"
        );
        invoice.addPrint(printLayout);
        await StarXpand.printDocument(event.device, invoice); 
      } catch (e) {
        emit(CashDrawerError(message: "Error When trying to print. Error: ${e.toString()}"));
      }
    });
  }
}
