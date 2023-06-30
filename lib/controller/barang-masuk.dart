import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> getBarangMasuk() async {
  List<dynamic> results = [];
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? server = preferences.getString("server");
    String? token = preferences.getString("token");
    if (server == null || token == null) {
      log("server : ${server.toString()} | token : ${token.toString()}");
      Fluttertoast.showToast(
        msg: "terjadi kesalahan server",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return results;
    }
    String endpoint = "http://$server:8000/api/barang-masuk";
    final response = await Dio().get(endpoint,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }));
    final List<dynamic> data = response.data["payload"] as List<dynamic>;
    results = data;
    log(data.toString());
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
  return results;
}

Future<Map<String, dynamic>?> getDetailBarangMasuk(int id) async {
  Map<String, dynamic>? result;
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? server = preferences.getString("server");
    String? token = preferences.getString("token");
    if (server == null || token == null) {
      log("server : ${server.toString()} | token : ${token.toString()}");
      Fluttertoast.showToast(
        msg: "terjadi kesalahan server",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return result;
    }
    String endpoint =
        "http://$server:8000/api/barang-masuk/${id.toString()}/detail";
    final response = await Dio().get(endpoint,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }));
    final Map<String, dynamic> data =
        response.data["payload"] as Map<String, dynamic>;
    result = data;
    log(data.toString());
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
