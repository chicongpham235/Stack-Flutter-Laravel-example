import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/configs/constants/app_colors.dart';
import 'package:intl/intl.dart';

class SelectPrinter extends StatefulWidget {
  const SelectPrinter({super.key});

  @override
  _SelectPrinterState createState() => _SelectPrinterState();
}

class _SelectPrinterState extends State<SelectPrinter> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _devicesMsg = "";
  final f = NumberFormat("\$###,###.00", "en_US");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));
    if (!mounted) return;
    bluetoothPrint.scanResults.listen((devices) {
      if (!mounted) return;
      setState(() {
        _devices = devices;
      });
      if (_devices.isEmpty) {
        setState(() {
          _devicesMsg = "No Devices";
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Printer'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _devices.isEmpty
          ? Center(child: Text(_devicesMsg))
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (c, i) {
                return ListTile(
                  leading: Icon(Icons.print),
                  title: Text(_devices[i].name!),
                  subtitle: Text(_devices[i].address!),
                  onTap: () {},
                );
              }),
    );
  }
}
