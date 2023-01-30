import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbHelper {
  int deleteIndex = 0;
  late Box box;
  DbHelper() {
    openbox();
  }

  openbox() {
    box = Hive.box('money');
  }

  Future addData(int amount, DateTime date, String note, String type,
      String catrgory) async {
    var value = {
      'amount': amount,
      'date': date,
      'type': type,
      'note': note,
      'category': catrgory
    };
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
    await box.delete(index);
  }

  compactAll() async {
    await box.compact();
  }

  incDeleteIndex() {
    deleteIndex++;
    print("delete index $deleteIndex");
  }
}
