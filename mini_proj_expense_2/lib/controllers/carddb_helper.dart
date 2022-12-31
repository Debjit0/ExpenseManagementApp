import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_proj_expense_2/controllers/db_helper.dart';

class CardDbHelper {
  late Box box;
  DbHelper() {
    openbox();
  }

  openbox() {
    box = Hive.box('card');
  }

  Future addData(int cardno, int cvv, String exp, String type) async {
    var value = {'cardno': cardno, 'cvv': cvv, 'exp': exp, 'type': type};
    box.add(value);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value(box.toMap());
    } else {
      return Future.value(box.toMap());
    }
  }

  deleteAll() {
    Hive.box('card').clear();
  }
}
