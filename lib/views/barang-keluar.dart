import 'package:flutter/material.dart';
import 'package:page_down_inventory/components/cardKeluar.dart';
import 'package:page_down_inventory/controller/barang-keluar.dart';

import '../components/card.dart';

class BarangKeluarPage extends StatefulWidget {
  const BarangKeluarPage({Key? key}) : super(key: key);

  @override
  State<BarangKeluarPage> createState() => _BarangKeluarPageState();
}

class _BarangKeluarPageState extends State<BarangKeluarPage> {
  bool isLoading = true;
  List<dynamic> data = [];

  @override
  void initState() {
    // TODO: implement initState
    _getBarangKeluar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barang Keluar"),
      ),
      floatingActionButton: isLoading
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/barang-keluar-list");
              },
              backgroundColor: Colors.green.shade400,
              child: const Icon(Icons.add),
            ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return refresh();
                },
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
                    : data.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Expanded(
                                child: Center(
                                  child: SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    child: Text("Data Tidak Tersedia"),
                                  ),
                                ),
                              )
                            ],
                          )
                        : SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: data.map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      int id = e["id"] as int;
                                      Navigator.pushNamed(
                                          context, "/barang-keluar-detail",
                                          arguments: id);
                                    },
                                    child: MyCardKeluar(
                                      height: 100,
                                      marginBottom: 5,
                                      noKeluar: e["no_keluar"].toString(),
                                      tanggal: e["tanggal"].toString(),
                                      customer: e["nama"].toString(),
                                      qty: e["sum_qty"] as int,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          if (value == 0) {
            Navigator.of(context).pop();
          }

          if (value == 1) {
            Navigator.of(context).popAndPushNamed("/barang-masuk");
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.inbox), label: "Barang Masuk"),
          BottomNavigationBarItem(
              icon: Icon(Icons.outbox), label: "Barang Keluar"),
        ],
        currentIndex: 2,
      ),
    );
  }

  refresh() async {
    _getBarangKeluar();
  }

  void _getBarangKeluar() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> tmpData = await getBarangKeluar();
    setState(() {
      isLoading = false;
      data = tmpData;
    });
  }
}
