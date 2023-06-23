import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String username = "Administrator";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hai,",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(username)
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      // SharedPreferences preferences =
                      //     await SharedPreferences.getInstance();
                      // preferences.remove("token");
                      // preferences.remove("role");
                      // Navigator.pushNamedAndRemoveUntil(context, "/login",
                      //     ModalRoute.withName("/login"));
                    },
                    child: const Icon(Icons.logout),
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 180,
                      width: 180,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/logo.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                    const Text(
                      "Selamat Datang Di Sistem Informasi Inventory Page Down Cloth Maker & Merch",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          if (value == 1) {
            Navigator.of(context).pushNamed("/barang-masuk");
          }

          if (value == 2) {
            Navigator.of(context).pushNamed("/barang-keluar");
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.inbox), label: "Barang Masuk"),
          BottomNavigationBarItem(
              icon: Icon(Icons.outbox), label: "Barang Keluar"),
        ],
        currentIndex: 0,
      ),
    );
  }
}
