import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_down_inventory/components/cardCart.dart';
import 'package:page_down_inventory/controller/barang-masuk.dart';
import 'package:page_down_inventory/controller/barang.dart';

class BarangMasukList extends StatefulWidget {
  const BarangMasukList({Key? key}) : super(key: key);

  @override
  State<BarangMasukList> createState() => _BarangMasukListState();
}

class _BarangMasukListState extends State<BarangMasukList> {
  bool isLoading = true;
  bool isLoadingSave = false;
  bool isLoadingCart = false;
  List<dynamic> data = [];
  int vSupplier = 0;
  String vKeterangan = '';

  List<Map<String, dynamic>> supplier = [
    {'id': 0, 'nama': '--pilih Supplier--'},
  ];

  List<dynamic> carts = [];

  @override
  void initState() {
    // TODO: implement initState
    _getInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaksi Barang Masuk"),
      ),
      floatingActionButton: isLoading
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/barang-masuk-add");
              },
              backgroundColor: Colors.green.shade400,
              child: const Icon(Icons.shopping_cart),
            ),
      body: SafeArea(
        child: isLoading
            ? Column(
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
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Supplier"),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButton(
                        value: vSupplier,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: supplier.map((e) {
                          return DropdownMenuItem(
                            value: e['id'] as int,
                            child: Text(e['nama'].toString()),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            vSupplier = newValue!;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text("Keterangan"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            vKeterangan = text;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hintText: "Keterangan"),
                        maxLines: 6,
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        // Navigator.popAndPushNamed(context, "/dashboard");
                        if (!isLoadingSave) {
                          _saveCart();
                        }
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green[400]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            isLoadingSave
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),
                            const Text(
                              "Simpan",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                      child: carts.isEmpty
                          ? RefreshIndicator(
                              onRefresh: () {
                                return refreshCart();
                              },
                              child: const SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                        "Tidak ada daftar barang masuk..."),
                                  ),
                                ),
                              ),
                            )
                          : isLoadingCart
                              ? Column(
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
                                )
                              : RefreshIndicator(
                                  onRefresh: () {
                                    return refreshCart();
                                  },
                                  child: SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: carts.map((e) {
                                              int id = e["id"] as int;
                                              return CardCart(
                                                onTap: () {
                                                  _deleteCart(id);
                                                },
                                                height: 120,
                                                marginBottom: 10,
                                                jenisBahan: e["barang"]["bahan"]
                                                        ["nama"]
                                                    .toString(),
                                                jenisBarang: e["barang"]
                                                        ["jenis_barang"]["nama"]
                                                    .toString(),
                                                ukuran: e["barang"]["ukuran"]
                                                    .toString(),
                                                warna: e["barang"]["warna"]
                                                        ["nama"]
                                                    .toString(),
                                                qty: e["qty"],
                                              );
                                            }).toList()),
                                      ],
                                    ),
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _getInformation() async {
    setState(() {
      isLoading = true;
    });

    supplier.removeRange(1, supplier.length);
    List<dynamic> dataSupplier = await getSupplier();
    List<dynamic> cartList = await getCartList();
    dataSupplier.forEach((element) {
      int id = element["id"] as int;
      String nama = element["nama"].toString();
      Map<String, dynamic> el = {'id': id, 'nama': nama};
      supplier.add(el);
    });
    setState(() {
      isLoading = false;
      carts = cartList;
    });
  }

  void _saveCart() async {
    setState(() {
      isLoadingSave = true;
    });
    Map<String, dynamic> dataBarangMasuk = {
      "supplier": vSupplier,
      "keterangan": vKeterangan
    };
    bool result = await saveBarangMasuk(dataBarangMasuk);
    setState(() {
      isLoadingSave = false;
    });
    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  void _deleteCart(int id) async {
    log(id.toString());
  }

  refreshCart() async {
    setState(() {
      isLoadingCart = true;
    });
    List<dynamic> cartList = await getCartList();
    setState(() {
      isLoadingCart = false;
      carts = cartList;
    });
  }
}
