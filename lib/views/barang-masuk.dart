import 'package:flutter/material.dart';
import 'package:page_down_inventory/components/card.dart';
import 'package:page_down_inventory/controller/barang-masuk.dart';

class BarangMasukPage extends StatefulWidget {
  const BarangMasukPage({Key? key}) : super(key: key);

  @override
  State<BarangMasukPage> createState() => _BarangMasukPageState();
}

class _BarangMasukPageState extends State<BarangMasukPage> {
  bool isLoading = true;
  List<dynamic> data = [];
  @override
  void initState() {
    // TODO: implement initState
    _getBarangMasuk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barang Masuk"),
      ),
      floatingActionButton: isLoading
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/barang-masuk-list");
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
                                          context, "/barang-masuk-detail",
                                          arguments: id);
                                    },
                                    child: MyCard(
                                      height: 100,
                                      marginBottom: 5,
                                      noMasuk: e["no_masuk"].toString(),
                                      tanggal: e["tanggal"].toString(),
                                      supplier:
                                          e["supplier"]["nama"].toString(),
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

          if (value == 2) {
            Navigator.of(context).popAndPushNamed("/barang-keluar");
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.inbox), label: "Barang Masuk"),
          BottomNavigationBarItem(
              icon: Icon(Icons.outbox), label: "Barang Keluar"),
        ],
        currentIndex: 1,
      ),
    );
  }

  refresh() async {
    _getBarangMasuk();
  }

  void _getBarangMasuk() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> tmpData = await getBarangMasuk();
    setState(() {
      isLoading = false;
      data = tmpData;
    });
  }
}
