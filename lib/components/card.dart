import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyCard extends StatelessWidget {
  final double height;
  final double marginBottom;
  final String noMasuk;
  final String tanggal;
  final String supplier;
  final int qty;
  const MyCard({
    Key? key,
    this.height = 100,
    this.marginBottom = 5,
    this.noMasuk = "-",
    this.tanggal = "-",
    this.supplier = "-",
    this.qty = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      margin: EdgeInsets.only(bottom: marginBottom),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black54.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("No. Masuk : $noMasuk"),
          Text("Tanggal : $tanggal"),
          Text("Supplier : $supplier"),
          Text("Total Barang : ${qty.toString()}"),
        ],
      ),
    );
  }
}
