import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
const mongoDBUrl = "mongodb+srv://pratyush-embelia:eC9cRHwus5Rr6iUb@embeliacluster.evgkcdj.mongodb.net/test?retryWrites=true&w=majority";


class MongoDB {
  static var db, collection;
  static connect() async {
    db = await Db.create(mongoDBUrl);
    await db.open();
    inspect(db);
    collection = db.collection('users');
  }
}