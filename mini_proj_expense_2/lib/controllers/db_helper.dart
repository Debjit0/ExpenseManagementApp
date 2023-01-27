import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_proj_expense_2/pages/addName.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbHelper {
  late Box box;
  DbHelper() {
    openbox();
  }

  openbox() {
    box = Hive.box('money');
  }

  Future addData(int amount, DateTime date, String note, String type) async {
    var value = {'amount': amount, 'date': date, 'type': type, 'note': note};
    box.add(value);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }

  deleteAll() {
    Hive.box('money').clear();
  }

  deleteOne(int index) async {
    //box.compact();
    await box.delete(index);
    await box.compact();
  }

  compactAll() async {
    await box.compact();
  }

  addName(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('name', name);
  }

  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('name');
  }
}
