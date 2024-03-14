import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapptry1/blocs/CashDrawer/cash_drawer_bloc.dart';
import 'package:posapptry1/pages/invoice_print_page.dart';
import 'package:posapptry1/pages/printing_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Test POS App", style: TextStyle(color: Colors.white),),
        surfaceTintColor: Colors.blueAccent,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                context.read<CashDrawerBloc>().add(OpenCashDrawer());
              },
              child: const Text("Open Cash Drawer"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final newInvoice = InvoicePrintPage();
                newInvoice.printInvoice();
              },
              child: const Text("Print Invoice"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PrintingPage()));
              },
              child: const Text("Print Invoice Via Bluetooth"),
            ),
            const SizedBox(height: 30),
            const Text("Cash Drawer Event Log", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 15),
            BlocBuilder<CashDrawerBloc, CashDrawerState>(
              builder: (context, state) {
                if (state is CashDrawerLoading) {
                  return const Center(
                    child: Text("Cash Drawer Loading..."),
                  );
                } else if (state is CashDrawerOpened){
                  List<Widget> devicesDetail = List.generate(
                    state.devices.length, 
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () => context.read<CashDrawerBloc>().add(PrintUsingInternalDevice(device: state.devices[index])),
                          tileColor: Colors.yellowAccent,
                          title: Text(state.devices[index].model.label),
                          subtitle: Text(state.devices[index].identifier),
                          trailing: Text(state.devices[index].interface.name)
                        ),
                      );
                    }
                  );
                  return Center(
                    child: Column(
                      children: [
                        const Text("Cash Drawer Opened"),
                        const SizedBox(height: 10),
                        ...devicesDetail
                      ],
                    ),
                  ); 
                } else if (state is CashDrawerError){
                  return Center(
                    child: Text("Cash Drawer Error. Message : ${state.message}"),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}