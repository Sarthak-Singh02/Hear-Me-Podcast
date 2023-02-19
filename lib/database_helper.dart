import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper{
      static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        image TEXT
      )
      """);
  }

//create database
   static Future<Database> db() async {
    return openDatabase(
      'dbtech.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }
  //add data
   static Future<int> createItem(int id,String title, String? descrption,String? image) async {
    final db = await SQLHelper.db();

    final data = {'id':id,'title': title, 'description': descrption,'image':image};
        id = await db.insert('items', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //get all data
    static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }
  
  //get single data
    static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }
//delete data
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
