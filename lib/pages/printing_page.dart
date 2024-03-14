import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posapptry1/blocs/Printer/printer_bloc.dart';

class PrintingPage extends StatefulWidget {
  const PrintingPage({super.key});

  @override
  State<PrintingPage> createState() => _PrintingPageState();
}

class _PrintingPageState extends State<PrintingPage> {
  @override
  void initState() {
    context.read<PrinterBloc>().add(GetPrinterDevices());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Printing Page"),
      ),
      body: ListView(
        children:  [
          const SizedBox(height: 20),
          const Text("Select Printer"),
          const SizedBox(height: 20),
          BlocBuilder<PrinterBloc, PrinterState>(
            builder: (context, state) {
              if (state is PrinterInitial || state is PrinterLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PrinterLoaded) {
                if (state.devices.isEmpty) {
                  return const Center(child: Text("No Device Detected"));
                }
                return Column(
                  children: List.generate(
                    state.devices.length, 
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () => context.read<PrinterBloc>().add(PrintUsingThisDevice(device: state.devices[index])),
                          tileColor: Colors.yellowAccent,
                          title: Text(state.devices[index].name.toString()),
                          subtitle: Text(state.devices[index].address.toString()),
                        ),
                      );
                    }
                  ),
                );
              } else if (state is PrinterPrintingSuccess) {
                return const Center(child: Text("Success Printing"));
              } else if (state is PrinterError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: CircularProgressIndicator()); 
              }
            },
          )
        ],
      ),
    );
  }
}