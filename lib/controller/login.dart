import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> IsLogin(Map<String, String> data) async {
  bool result = false;
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? srv = preferences.getString("server");
    String server = "";
    if (srv == null) {
      Fluttertoast.showToast(
        msg: "terjadi kesalahan server (server belum di set...) ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return result;
    }
    server = "http://$srv:8000/api";
    var formData = FormData.fromMap(data);
    final response = await Dio().post("$server/login",
        options: Options(headers: {"Accept": "application/json"}),
        data: formData);
    log(response.toString());
    final String token = response.data["payload"]["access_token"] as String;
    log(token);
    preferences.setString("token", token);
    Fluttertoast.showToast(
      msg: "Login Success...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    result = true;
  } on DioException catch (e) {
    log("dio error : " + e.response!.data.toString());
    Fluttertoast.showToast(
      msg: "terjadi kesalahan server ${e.response!.data.toString()}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } catch (e) {
    log("error" + e.toString());
    Fluttertoast.showToast(
      msg: "terjadi kesalahan server ${e.toString()}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  return result;
}
