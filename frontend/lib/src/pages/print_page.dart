import 'package:flutter/material.dart';
import 'package:frontend/src/configs/constants/app_colors.dart';
import 'package:frontend/src/helpers/loading_dialog.dart';
import 'package:frontend/src/pages/select_printer_page.dart';
import 'package:frontend/src/providers/sale.dart';
import 'package:frontend/src/providers/auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PrintPage extends StatefulWidget {
  const PrintPage({super.key});

  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  List<dynamic> sales = [];
  Map<String, dynamic>? vendor;
  final List<Map<String, dynamic>> data = [
    {'title': 'Cadbury Dairy Milk', 'price': 15, 'qty': 2},
    {'title': 'Parle-G Gluco Biscut', 'price': 5, 'qty': 5},
    {'title': 'Fresh Onion - 1KG', 'price': 20, 'qty': 1},
    {'title': 'Fresh Sweet Lime', 'price': 20, 'qty': 5},
    {'title': 'Maggi', 'price': 10, 'qty': 5},
  ];
  final f = NumberFormat("\$###,###.00", "en_US");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoaderDialog(context);
      await Provider.of<Sale>(context, listen: false).list();
      sales = Provider.of<Sale>(context, listen: false).sales!;
      setState(() {
        vendor = Provider.of<Auth>(context, listen: false).user;
      });
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _total = 0;
    _total = data.map((e) => e['price'] * e['qty']).reduce(
          (value, element) => value + element,
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${vendor == null ? '' : vendor!['display_name']}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (c, i) {
                return ListTile(
                  title: Text(
                    data[i]['title'].toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${f.format(data[i]['price'])} x ${data[i]['qty']}",
                  ),
                  trailing: Text(
                    f.format(
                      data[i]['price'] * data[i]['qty'],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  "Total: ${f.format(_total)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 80,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => SelectPrinter(data),
                          //   ),
                          // );
                        },
                        icon: Icon(
                          Icons.print,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Print',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.primaryColor[300],
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 20)),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
