import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CardDbHelper {
  late Box box;
  DbHelper() {
    openbox();
  }

  openbox() {
    box = Hive.box('card');
  }

  Future addData(
      int cardno, int cvv, String exp, String type, String bankname) async {
    var value = {
      'cardno': cardno,
      'cvv': cvv,
      'exp': exp,
      'type': type,
      'bankname': bankname
    };
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
