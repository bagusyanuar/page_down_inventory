import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_down_inventory/components/cardDetail.dart';
import 'package:page_down_inventory/components/card.dart';
import 'package:page_down_inventory/controller/barang-masuk.dart';

class BarangMasukDetailPage extends StatefulWidget {
  const BarangMasukDetailPage({Key? key}) : super(key: key);

  @override
  State<BarangMasukDetailPage> createState() => _BarangMasukDetailPageState();
}

class _BarangMasukDetailPageState extends State<BarangMasukDetailPage> {
  bool isLoading = true;
  String supplier = "-";
  String noMasuk = "-";
  String tanggal = "-";
  int totalBarang = 0;
  List<dynamic> details = [];
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int id = ModalRoute.of(context)!.settings.arguments as int;
      log("Argument Value ${id.toString()}");
      _getBarangMasukDetail(id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barang Masuk Detail"),
      ),
      body: SafeArea(
        child: isLoading
            ? SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.green,
                      ),
                    ),
                    const Center(
                      child: Text("Sedang Mengunduh Data..."),
                    )
                  ],
                ),
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("No. Masuk : $noMasuk"),
                    Text("Tanggal : $tanggal"),
                    Text("Supplier : $supplier"),
                    Text("Total Barang : ${totalBarang.toString()}"),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        "Daftar Barang Masuk",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: details.map((e) {
                            return MyCardDetail(
                              height: 100,
                              marginBottom: 10,
                              qty: e["qty"] as int,
                              jenisBarang: e["barang"]["jenis_barang"]["nama"]
                                  .toString(),
                              jenisBahan:
                                  e["barang"]["bahan"]["nama"].toString(),
                              warna: e["barang"]["warna"]["nama"].toString(),
                              ukuran: e["barang"]["ukuran"].toString(),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void _getBarangMasukDetail(int id) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic>? data = await getDetailBarangMasuk(id);
    if (data != null) {
      setState(() {
        noMasuk = data["no_masuk"] as String;
        supplier = data["supplier"]["nama"] as String;
        tanggal = data["tanggal"] as String;
        totalBarang = data["sum_qty"] as int;
        details = data["detail"] as List<dynamic>;
      });
    }
    setState(() {
      isLoading = false;
    });
    log(data.toString());
  }
}
