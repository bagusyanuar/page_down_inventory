import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/card.dart';

class BarangKeluarPage extends StatefulWidget {
  const BarangKeluarPage({Key? key}) : super(key: key);

  @override
  State<BarangKeluarPage> createState() => _BarangKeluarPageState();
}

class _BarangKeluarPageState extends State<BarangKeluarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barang Keluar"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green.shade400,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                MyCard(
                  height: 120,
                  marginBottom: 10,
                ),
                MyCard(
                  height: 120,
                  marginBottom: 10,
                ),
                MyCard(
                  height: 120,
                  marginBottom: 10,
                ),
                MyCard(
                  height: 120,
                  marginBottom: 10,
                ),
                MyCard(
                  height: 120,
                  marginBottom: 10,
                ),
                MyCard(
                  height: 120,
                  marginBottom: 10,
                ),
                MyCard(
                  height: 120,
                  marginBottom: 10,
                ),
                MyCard(
                  height: 120,
                  marginBottom: 10,
                ),
              ],
            ),
          ),
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
}
