import 'package:flutter/material.dart';
import 'package:frontend/src/configs/constants/app_colors.dart';
import 'package:frontend/src/helpers/loading_dialog.dart';
import 'package:frontend/src/providers/sale.dart';
import 'package:provider/provider.dart';

class TvScreenPage extends StatefulWidget {
  const TvScreenPage({super.key});

  @override
  State<TvScreenPage> createState() => _TvScreenPageState();
}

class _TvScreenPageState extends State<TvScreenPage> {
  List<dynamic> sales = [];

  final pendingOrdersChildren = <Widget>[];
  final delivereOrdersChildren = <Widget>[];
  final completeOrdersChildren = <Widget>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showLoaderDialog(context);
      await Provider.of<Sale>(context, listen: false).list();
      sales = Provider.of<Sale>(context, listen: false).sales!;
      Navigator.of(context).pop();

      _onRenderTableContent();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onRenderTableContent() {
    for (var item in sales) {
      String table = item["ordertype"] == "takeaway"
          ? "Take Away"
          : "Table ${item["table_number"]}";
      if (item["deliverysstatus"] != "vanished") {
        if (item["deliverysstatus"] == "pending") {
          setState(() {
            pendingOrdersChildren.add(Card(
              surfaceTintColor: Colors.transparent,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('#dee2e6'))),
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${item["sale_code"]}"),
                      SizedBox(width: 5),
                      Text("${table}")
                    ],
                  )),
            ));
          });
        }
        if (item["deliverysstatus"] == "delivered") {
          setState(() {
            delivereOrdersChildren.add(Card(
              surfaceTintColor: Colors.transparent,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('#dee2e6'))),
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${item["sale_code"]}"),
                      SizedBox(width: 5),
                      Text("${table}")
                    ],
                  )),
            ));
          });
        }
        if (item["deliverysstatus"] == "completed") {
          setState(() {
            completeOrdersChildren.add(Card(
              surfaceTintColor: Colors.transparent,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('#dee2e6'))),
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${item["sale_code"]}"),
                      SizedBox(width: 5),
                      Text("${table}")
                    ],
                  )),
            ));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 80),
                  Container(
                      alignment: Alignment.topCenter,
                      child: Table(
                        border: TableBorder.all(color: HexColor('#dee2e6')),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: <TableRow>[
                          TableRow(
                            children: <Widget>[
                              Container(
                                  child:
                                      Column(children: pendingOrdersChildren)),
                              Container(
                                  child:
                                      Column(children: delivereOrdersChildren)),
                              Container(
                                  child:
                                      Column(children: completeOrdersChildren))
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
            )),
        Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Table(
                border: TableBorder.all(color: HexColor('#dee2e6')),
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'ORDER RECEIVED',
                            style: TextStyle(
                                color: HexColor('#39bdc4'),
                                fontWeight: FontWeight.w600),
                          )),
                      Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'PROCESSING',
                            style: TextStyle(
                                color: HexColor('#1f1691'),
                                fontWeight: FontWeight.w600),
                          )),
                      Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'READY TO PICKUP',
                            style: TextStyle(
                                color: HexColor('#0b8451'),
                                fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
