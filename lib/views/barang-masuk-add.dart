import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_down_inventory/components/cardCart.dart';
import 'package:page_down_inventory/controller/barang-masuk.dart';
import 'package:page_down_inventory/controller/barang.dart';

class BarangMasukAddPage extends StatefulWidget {
  const BarangMasukAddPage({Key? key}) : super(key: key);

  @override
  State<BarangMasukAddPage> createState() => _BarangMasukAddPageState();
}

class _BarangMasukAddPageState extends State<BarangMasukAddPage> {
  int vJenisBarang = 0;
  int vJenisBahan = 0;
  int vWarna = 0;
  int vQty = 0;
  String vUkuran = '';
  String vKeterangan = '';
  int vSupplier = 0;
  bool isLoadingFirst = true;
  bool isLoadingAdd = false;
  List<Map<String, dynamic>> jenisBarang = [
    {'id': 0, 'nama': '--pilih jenis barang--'},
  ];
  List<Map<String, dynamic>> jenisBahan = [
    {'id': 0, 'nama': '--pilih jenis bahan--'},
  ];

  List<Map<String, dynamic>> warna = [
    {'id': 0, 'nama': '--pilih warna--'},
  ];

  List<Map<String, dynamic>> ukuran = [
    {'id': '', 'nama': '--pilih ukuran--'},
    {'id': 'S', 'nama': 'S'},
    {'id': 'M', 'nama': 'M'},
    {'id': 'L', 'nama': 'L'},
    {'id': 'XL', 'nama': 'XL'},
  ];

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
        title: const Text("Tambah Barang Masuk"),
      ),
      body: SafeArea(
        child: isLoadingFirst
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
                height: double.infinity,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                      const Text("Jenis Barang"),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton(
                          value: vJenisBarang,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: jenisBarang.map((e) {
                            return DropdownMenuItem(
                              value: e['id'] as int,
                              child: Text(e['nama'].toString()),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              vJenisBarang = newValue!;
                            });
                          },
                        ),
                      ),
                      const Text("Jenis Bahan"),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton(
                          value: vJenisBahan,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: jenisBahan.map((e) {
                            return DropdownMenuItem(
                              value: e['id'] as int,
                              child: Text(e['nama'].toString()),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              vJenisBahan = newValue!;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Warna"),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: DropdownButton(
                                  value: vWarna,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: warna.map((e) {
                                    return DropdownMenuItem(
                                      value: e['id'] as int,
                                      child: Text(e['nama'].toString()),
                                    );
                                  }).toList(),
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      vWarna = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Ukuran"),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: DropdownButton(
                                  value: vUkuran,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: ukuran.map((e) {
                                    return DropdownMenuItem(
                                      value: e['id'] as String,
                                      child: Text(e['nama'].toString()),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      vUkuran = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text("Qty"),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              vQty = int.parse(text);
                            });
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Server"),
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
                      GestureDetector(
                        onTap: () {
                          // Navigator.popAndPushNamed(context, "/dashboard");
                          // if (!isLoadingAdd) {
                          //   _login();
                          // }
                          _addTocart();
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
                              isLoadingAdd
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
                                "Tambah",
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
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: carts.isEmpty
                            ? const SizedBox(
                                height: 100,
                                child: Center(
                                  child:
                                      Text("Tidak ada daftar barang masuk..."),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      CardCart(
                                        height: 120,
                                        marginBottom: 5,
                                      ),
                                      CardCart(
                                        height: 120,
                                        marginBottom: 5,
                                      ),
                                      CardCart(
                                        height: 120,
                                        marginBottom: 5,
                                      )
                                    ],
                                  ),
                                  const Divider(),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.popAndPushNamed(context, "/dashboard");
                                      if (!isLoadingAdd) {
                                        // _login();
                                      }
                                    },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green[400]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          isLoadingAdd
                                              ? Container(
                                                  height: 20,
                                                  width: 20,
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child:
                                                      const CircularProgressIndicator(
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
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _getInformation() async {
    setState(() {
      isLoadingFirst = true;
    });
    supplier.removeRange(1, jenisBarang.length);
    jenisBarang.removeRange(1, jenisBarang.length);
    jenisBahan.removeRange(1, jenisBahan.length);
    warna.removeRange(1, warna.length);

    List<dynamic> dataSupplier = await getSupplier();
    List<dynamic> dataJenisBarang = await getJenisBarang();
    List<dynamic> dataJenisBahan = await getJenisBahan();
    List<dynamic> dataWarna = await getWarna();

    dataSupplier.forEach((element) {
      int id = element["id"] as int;
      String nama = element["nama"].toString();
      Map<String, dynamic> el = {'id': id, 'nama': nama};
      supplier.add(el);
    });

    dataJenisBarang.forEach((element) {
      int id = element["id"] as int;
      String nama = element["nama"].toString();
      Map<String, dynamic> el = {'id': id, 'nama': nama};
      jenisBarang.add(el);
    });
    dataJenisBahan.forEach((element) {
      int id = element["id"] as int;
      String nama = element["nama"].toString();
      Map<String, dynamic> el = {'id': id, 'nama': nama};
      jenisBahan.add(el);
    });
    dataWarna.forEach((element) {
      int id = element["id"] as int;
      String nama = element["nama"].toString();
      Map<String, dynamic> el = {'id': id, 'nama': nama};
      warna.add(el);
    });

    setState(() {
      isLoadingFirst = false;
    });
    log(dataJenisBarang.toString());
  }

  void _addTocart() async {
    Map<String, dynamic> dataCart = {
      'jenis_barang': vJenisBarang,
      'bahan': vJenisBahan,
      'warna': vWarna,
      'ukuran': vUkuran,
      'qty': vQty,
    };

    bool result = await isSaveCart(dataCart);
  }
}
