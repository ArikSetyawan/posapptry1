// import 'package:pdf/pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class InvoicePrintPage {

  void printInvoice() async {
    final Document doc = Document();
    doc.addPage(
      Page(
        pageFormat: PdfPageFormat.roll57,
        build: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Center(child: Text("INVOICE", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
              SizedBox(height: 10),
              clientDesctiption("Client1", "Wakanda Utara"),
              SizedBox(height: 25),
              itemsTable(),
              Divider(),
              // Items Total Price Details
              itemTotalPriceDetail(),
            ]
          );
        },
      )
    );

    await Printing.layoutPdf(onLayout: (format) async => doc.save());
  }

  Table itemTotalPriceDetail() {
    return Table(
      columnWidths: {
        0: const FlexColumnWidth(8),
        1: const FlexColumnWidth(4),
      },
      children: [
        // Grand Total
        TableRow(
          children: [
            Table(
              columnWidths: {
                0: const FlexColumnWidth(5),
                1: const FlexColumnWidth(1),
                2: const FlexColumnWidth(6),
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide()
                    )
                  ),
                  children: [
                    Text("Grand Total"),
                    Text(":"),
                    Text("Rp. 47.147", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                  ]
                ),
              ]
            )
          ]
        ),
      ]
    );
  }

  Table itemsTable() {
    return Table(
      columnWidths: {
        1: const FlexColumnWidth(4),
        3: const FlexColumnWidth(2),
        4: const FlexColumnWidth(3),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide()
            )
          ),
          children: [
            Text("Barang", textAlign: TextAlign.left),
            Text("Qty", textAlign: TextAlign.center),
            Text("Harga", textAlign: TextAlign.center)
          ]
        ), TableRow(
          children: [
            Text("Test", textAlign: TextAlign.center),
            Text("8", textAlign: TextAlign.center),
            Text("46.519", textAlign: TextAlign.right)
          ]
        ),
        TableRow(
          children: [
            Text("Test", textAlign: TextAlign.center),
            Text("8", textAlign: TextAlign.center),
            Text("46.519", textAlign: TextAlign.right)
          ]
        )
      ]
    );
  }

  Table clientDesctiption(String clientName, String clientAddress) {
    return Table(
      columnWidths: {
        0: const FixedColumnWidth(150),
        1: const FixedColumnWidth(10),
        2: const FixedColumnWidth(300),
      },
      tableWidth: TableWidth.min,
      children: [
        TableRow(
          children: [
            Text("Nama"),
            Text(":"),
            Text(clientName)
          ]
        ),
        TableRow(
          children: [
            Text("Alamat"),
            Text(":"),
            Text(clientAddress)
          ]
        ),
      ]
    );
  }
}