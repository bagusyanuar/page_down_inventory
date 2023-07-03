import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_down_inventory/components/cardDetail.dart';
import 'package:page_down_inventory/controller/barang-keluar.dart';

class BarangKeluarDetailPage extends StatefulWidget {
  const BarangKeluarDetailPage({Key? key}) : super(key: key);

  @override
  State<BarangKeluarDetailPage> createState() => _BarangKeluarDetailPageState();
}

class _BarangKeluarDetailPageState extends State<BarangKeluarDetailPage> {
  bool isLoading = true;
  String customer = "-";
  String noKeluar = "-";
  String tanggal = "-";
  int totalBarang = 0;
  List<dynamic> details = [];

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int id = ModalRoute.of(context)!.settings.arguments as int;
      log("Argument Value ${id.toString()}");
      _getBarangKeluarDetail(id);
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
                    Text("No. Keluar : $noKeluar"),
                    Text("Tanggal : $tanggal"),
                    Text("Customer : $customer"),
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

  void _getBarangKeluarDetail(int id) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic>? data = await getDetailBarangKeluar(id);
    if (data != null) {
      setState(() {
        noKeluar = data["no_keluar"] as String;
        customer = data["nama"] as String;
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
