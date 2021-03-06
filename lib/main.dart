import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqf_lite_project/app/db_helper.dart';
import 'package:sqf_lite_project/data/db/sqf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  SQF sqf=SQF();
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  void insertNote(String note)async{

   var res= await sqf.insertData(DBHelper.TABLE_NOTE,{
     "note":note,
    
   });}
   void insertUser(String name,int age)async{

     var res= await sqf.insertData(DBHelper.TABLE_USER,{
       "name":name,
       "age":age,
     });
   print(res>0?"success added new user ":"fail insert");
   print("insert raw num $res");
  }
  void insertFavourite(String name)async{

    var res= await sqf.insertData(DBHelper.TABLE_FAVOURITE,{
      "fk_user":2,
      "fk_note":1,
      "note":name
    });
    print(res>0?"success added new user ":"fail insert");
    print("insert raw num $res");
  }

  void getFavourites()async{

    var res= await sqf.readData(tableName: DBHelper.TABLE_FAVOURITE);
    print(res.toString());

  }
  void getNotes(int userId)async{

    var res= await sqf.readData(tableName: DBHelper.TABLE_NOTE);
    print(res.toString());

  }
  void getUsers()async{
    var res= await sqf.readData(tableName: DBHelper.TABLE_USER);
    print(res.toString());

  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                insertFavourite("hi ezzat");
              },
              tooltip: 'fav',
              child: const Icon(Icons.favorite_border),
            ),
            SizedBox(height: 20,),
            FloatingActionButton(
              onPressed: () {
                getFavourites();
              },
              tooltip: 'add',
              child: const Icon(Icons.favorite),
            ),
            SizedBox(height: 20,),
            FloatingActionButton(
              onPressed: () {
                insertUser("ezzat mohamed",Random().nextInt(100));
              },
              tooltip: 'add',
              child: const Icon(Icons.add),
            ),
            SizedBox(height: 20,),

            FloatingActionButton(
              onPressed: () {

insertNote("note num ${Random().nextInt(10)}");
              },
              tooltip: 'add',
              child: const Icon(Icons.add),
            ),

            SizedBox(height: 20,),
            FloatingActionButton(
              onPressed: () {
                getUsers();
              },
              tooltip: 'read',
              child: const Icon(Icons.receipt),
            ),
            SizedBox(height: 20,),
            FloatingActionButton(
              onPressed: () {
getNotes(1);
              },
              tooltip: 'read',
              child: const Icon(Icons.receipt),
            ),
            SizedBox(height: 20,),
            FloatingActionButton(
              onPressed: () async{
             var res= await sqf.deleteData("Notes", [1]);
             print(res.toString());
              },
              tooltip: 'read',
              child: const Icon(Icons.delete),
            ),
            SizedBox(height: 20,),
            FloatingActionButton(
              onPressed: () async{
                var res= await sqf.updateData("Notes","ezzat ${Random().nextInt(10)}",2);
                print(res.toString());
              },
              tooltip: 'read',
              child: const Icon(Icons.update),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
