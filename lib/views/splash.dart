import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                    "Sistem Informasi Inventory Page Down Cloth Maker & Merch",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text("Fariz Deva \u00a9 2022"),
            ),
          )
        ],
      ),
    );
  }

  void _initSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences preference = await SharedPreferences.getInstance();
    String? token = preference.getString("token");
    if (token != null) {
      Navigator.popAndPushNamed(context, "/dashboard");
    } else {
      Navigator.popAndPushNamed(context, "/login");
    }
    // ignore: use_build_context_synchronously
  }
}
