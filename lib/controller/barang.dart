import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> getSupplier() async {
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
    String endpoint = "http://$server:8000/api/supplier";
    final response = await Dio().get(endpoint,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }));
    final List<dynamic> data = response.data["payload"] as List<dynamic>;
    results = data;
    log(data.toString());
  } on DioException catch (e) {
    log("dio error : ${e.response!.data.toString()}");
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
    log("error : ${e.toString()}");
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

Future<List<dynamic>> getJenisBarang() async {
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
    String endpoint = "http://$server:8000/api/jenis-barang";
    final response = await Dio().get(endpoint,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }));
    final List<dynamic> data = response.data["payload"] as List<dynamic>;
    results = data;
    log(data.toString());
  } on DioException catch (e) {
    log("dio error : ${e.response!.data.toString()}");
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
    log("error : ${e.toString()}");
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

Future<List<dynamic>> getJenisBahan() async {
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
    String endpoint = "http://$server:8000/api/bahan";
    final response = await Dio().get(endpoint,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }));
    final List<dynamic> data = response.data["payload"] as List<dynamic>;
    results = data;
    log(data.toString());
  } on DioException catch (e) {
    log("dio error : ${e.response!.data.toString()}");
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
    log("error : ${e.toString()}");
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

Future<List<dynamic>> getWarna() async {
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
    String endpoint = "http://$server:8000/api/warna";
    final response = await Dio().get(endpoint,
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        }));
    final List<dynamic> data = response.data["payload"] as List<dynamic>;
    results = data;
    log(data.toString());
  } on DioException catch (e) {
    log("dio error : ${e.response!.data.toString()}");
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
    log("error : ${e.toString()}");
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
