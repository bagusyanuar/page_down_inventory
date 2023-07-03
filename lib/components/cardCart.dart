import 'package:flutter/material.dart';

class CardCart extends StatelessWidget {
  final double height;
  final double marginBottom;
  final String jenisBarang;
  final String jenisBahan;
  final String warna;
  final String ukuran;
  final int qty;
  final int id;
  final VoidCallback? onTap;
  const CardCart({
    Key? key,
    this.height = 100,
    this.marginBottom = 5,
    this.jenisBarang = "-",
    this.jenisBahan = "-",
    this.warna = "-",
    this.ukuran = "-",
    this.qty = 0,
    this.id = 0,
    this.onTap,
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      "Hapus",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
