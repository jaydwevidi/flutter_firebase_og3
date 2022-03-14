import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
import 'dart:convert';
import 'package:flutter_firebase_og3/User.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String xd = "haha";
  var muserlist = <User>[];

  @override
  void initState() {
    getValues();
  }

  void getValues(){
    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("aa");
    //dbRef.child("$_counter").set(sqrt(_counter));

    dbRef.onValue.listen((event) {
      muserlist.clear();
      var todo = event.snapshot.children;

      for(var ii in todo){
        print(ii.value.toString());
        String userName = ii.child("username").value.toString();
        String description = ii.child("avatar").value.toString();
        print("idd = $userName");
        muserlist.add(User(UserName: userName, description: description, id: ii.key.toString()));

      }
      setState(() {
      });

    });
  }

  void _incrementCounter() {

    setState(() {
      getValues();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView.builder(
          itemCount: muserlist.length,
          itemBuilder: (

            BuildContext context, int index) {

          return Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,

                  backgroundImage: NetworkImage(muserlist[index].description ),
                ),
                title: Text(muserlist[index].UserName),
                trailing: Text(muserlist[index].id),
              ),
            ),
          );
        },

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
