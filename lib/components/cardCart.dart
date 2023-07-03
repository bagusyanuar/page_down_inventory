import 'package:flutter/material.dart';

class CardCart extends StatelessWidget {
  final double height;
  final double marginBottom;
  final String jenisBarang;
  final String jenisBahan;
  final String warna;
  final String ukuran;
  final int qty;
  const CardCart({
    Key? key,
    this.height = 100,
    this.marginBottom = 5,
    this.jenisBarang = "-",
    this.jenisBahan = "-",
    this.warna = "-",
    this.ukuran = "-",
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
          Text("Jenis Barang : $jenisBarang"),
          Text("Jenis Bahan : $jenisBahan"),
          Text("Warna : $warna"),
          Text("Ukuran : $ukuran"),
          Text("Jumlah : ${qty.toString()}"),
        ],
      ),
    );
  }
}
