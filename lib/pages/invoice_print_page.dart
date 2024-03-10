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
              clientDesctiption("Test", "", ""),
              SizedBox(height: 25),
              itemsTable(),
              // Items Total Price Details
              itemTotalPriceDetail(),
              // Payment Account Detail
              paymentAccountDetail()
            ]
          );
        },
      )
    );

    await Printing.layoutPdf(onLayout: (format) async => doc.save());
  }

  Column paymentAccountDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          columnWidths: {
            0: const FixedColumnWidth(250),
          },
          tableWidth: TableWidth.min,
          children: [
            // Harga Emas, Total, PPN, and PPH
            TableRow(
              children: [
                Table(
                  columnWidths: {
                    0: const FixedColumnWidth(30),
                    1: const FixedColumnWidth(5),
                    2: const FixedColumnWidth(100),
                  },
                  children: [
                    TableRow(
                      children: [
                        Text("Bank"),
                        Text(":"),
                        Text("BCA",),
                      ]
                    ),
                    TableRow(
                      children: [
                        Text("A/N"),
                        Text(":"),
                        Text("PT Test",),
                      ]
                    )
                  ]
                )
              ]
            )
          ]
        ),
        Table(
          columnWidths: {
            0: const FixedColumnWidth(250),
            1: const FlexColumnWidth(3),
            2: const FlexColumnWidth(3)
          },
          tableWidth: TableWidth.min,
          children: [
            // Harga Emas, Total, PPN, and PPH
            TableRow(
              children: [
                Table(
                  columnWidths: {
                    0: const FixedColumnWidth(30),
                    1: const FixedColumnWidth(5),
                    2: const FixedColumnWidth(100),
                  },
                  children: [
                    TableRow(
                      children: [
                        Text("A/C"),
                        Text(":"),
                        Text("123-123123123",),
                      ]
                    )
                  ]
                ),
                SizedBox.shrink(),
                Text("Hormat Kami\n\n\n\n\n\n(............................)", textAlign: TextAlign.center),
              ]
            ),                 
          ]
        ),
      ]
    );
  }

  Table itemTotalPriceDetail() {
    return Table(
      columnWidths: {
        0: const FlexColumnWidth(8),
        1: const FlexColumnWidth(4),
      },
      children: [
        // Harga Emas, Total, PPN, and PPH
        TableRow(
          children: [
            Text("Harga Produk / pcs : Rp 979.500"),
            Table(
              columnWidths: {
                0: const FlexColumnWidth(5),
                1: const FlexColumnWidth(1),
                2: const FlexColumnWidth(6),
              },
              children: [
                TableRow(
                  children: [
                    Text("Total"),
                    Text(":"),
                    Text("46.519.393", textAlign: TextAlign.right),
                  ]
                ),
                TableRow(
                  children: [
                    Text("PPN 1.1%"),
                    Text(":"),
                    Text("511.713", textAlign: TextAlign.right),
                  ]
                ),
                TableRow(
                  children: [
                    Text("PPh 22 0.25%"),
                    Text(":"),
                    Text("116.298", textAlign: TextAlign.right),
                  ]
                )
              ]
            )
          ]
        ),
        // Grand Total
        TableRow(
          children: [
            Text("Pembayaran dapat dilakukan pada rekening"),
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
                    Text("47.147.404", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right),
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
        0: const FlexColumnWidth(1),
        1: const FlexColumnWidth(4),
        2: const FlexColumnWidth(2),
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
            Text("No.", textAlign: TextAlign.center),
            Text("Jenis Barang", textAlign: TextAlign.center),
            Text("Qty", textAlign: TextAlign.center),
            Text("Berat Kotor", textAlign: TextAlign.center),
            Text("Jumlah (Rupiah)", textAlign: TextAlign.center)
          ]
        )
      ]..add(TableRow(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide()
            )
          ),
          children: [
            Text("1", textAlign: TextAlign.center),
            Text("Test", textAlign: TextAlign.center),
            Text("8", textAlign: TextAlign.center),
            Text("111,54", textAlign: TextAlign.center),
            Text("46.519.393", textAlign: TextAlign.right)
          ]
        )
      )
    );
  }

  Table clientDesctiption(String clientName, String clientAddress, String clientTaxID) {
    return Table(
      columnWidths: {
        0: const FixedColumnWidth(80),
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
        TableRow(
          children: [
            Text("NPWP / NIK"),
            Text(":"),
            Text(clientTaxID)
          ]
        )
      ]
    );
  }

  Row headerPrintPage() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PT Setyawanarik", style: const TextStyle(fontSize: 14)),
            Text("Jl. Wakanda Utara", style: const TextStyle(fontSize: 10)),
            Text("Jawa Timur - Indonesi", style: const TextStyle(fontSize: 10))
          ]
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Tanggal"),
                Text(":"),
                Text("28-01-2024")
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("No Invoice"),
                Text(":"),
                Text("1275x/xX/2024")
              ],
            )
          ]
        )
      ]
    );
  }
}