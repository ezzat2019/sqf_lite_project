import 'package:sqf_lite_project/app/db_helper.dart';
import 'package:sqf_lite_project/data/db/dp_operation.dart';
import 'package:sqflite/sqflite.dart';

class SQF implements DBOperation{
   Database? _db;


   Future<Database?> get db async{
    if(_db==null)
      {
        _db=await initDB();
        return _db;
      }else{
      return _db;
    }
   }

  @override
  Future<Database?> initDB() async{
   String dbPath= await getDatabasesPath();
   String path=dbPath+"/notes_db4.db";
   Database database= await openDatabase(path,version: 2,onCreate: (db, version) async{
     // await db.execute(
     //     '''
     //
     //     CREATE TABLE "Notes" ("id" INTEGER PRIMARY KEY, "note" TEXT,
     //     "fk_user" integer ,
     //     foreign key ("fk_user") references "User" ("user_id")
     //     )
     //
     //     ''');
     await db.execute(
         '''
         
         CREATE TABLE "${DBHelper.TABLE_NOTE}" ("id" INTEGER PRIMARY KEY, "note" TEXT
         )
         
         ''');
     await db.execute(
         '''
         
         CREATE TABLE "${DBHelper.TABLE_USER}" ("user_id" INTEGER PRIMARY KEY, "name" TEXT,
         "age" integer not null
         )
         
         ''');
     await db.execute(
         '''
         
         CREATE TABLE "${DBHelper.TABLE_FAVOURITE}" ("fav_id" INTEGER PRIMARY KEY, "fk_user" integer,
          "fk_note" integer, "note" text,foreign key ("fk_user") references "${DBHelper.TABLE_USER}" ("user_id"),
        
         foreign key ("fk_note") references "${DBHelper.TABLE_NOTE}" ("id")
        
         )
         
         ''');
    print("data base created");
     },onUpgrade:(db,oldV,newV){

   });
   return database;
  }

  @override
  deleteData(String  tableName,List ids) async{
    var myDB=await db;
    var res= await myDB!.delete(tableName,where: "id = ?",whereArgs:ids );
    return res;
  }

  @override
  readData({required String tableName, String? where}) async{
    var myDB=await db;
    var res= await myDB!.query(tableName,where:where );
    return res;
  }

  @override
  updateData(String tableName,String newNote,int id) async{
    var myDB=await db;
    var res= await myDB!.update(tableName,{"note":newNote},where: "id= $id");
    return res;
  }

  @override
  insertData(String tableName,Map<String,Object?> data) async{
    var myDB=await db;
    var res= await myDB!.insert(tableName,data);
    return res;
  }


}