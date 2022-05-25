import 'package:sqflite/sqflite.dart';

abstract class DBOperation{
  Future<Database?> initDB();
  readData({required String tableName, String? where});
  updateData(String tableName,String newNote,int id);
  deleteData(String tableName,List ids);
  insertData(String tableName,Map<String,Object> data);
}