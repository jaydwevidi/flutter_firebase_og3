// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  void getValues(){

    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("aa");


    dbRef.onValue.listen((event) {
      muserlist.clear();
      var todo = event.snapshot.children;

      for(var ii in todo){
        print(ii.value.toString());
        String userName = ii.child("username").value.toString();
        String description = ii.child("avatar").value.toString();
        String characterd = ii.child("cd").value.toString();
        print("idd = $userName");
        muserlist.add(User(UserName: userName, description: description, id: ii.key.toString() , characterd: characterd));

      }
      setState(() {
      });

    });
  }

  void _incrementCounter() {
    var rn = random(100, 200);

    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("aa").child((rn).toString());
    dbRef.child("username").set("Barbara Gordon");
    dbRef.child("avatar").set("https://www.dccomics.com/sites/default/files/field/image/BabsCasting_60073b823ebff3.73076079.jpg");
    dbRef.child("cd").set("https://www.dccomics.com/sites/default/files/field/image/BabsCasting_60073b823ebff3.73076079.jpg");

    setState(() {
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

          return Container(
            margin:  EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
            decoration:  BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 0, 116, 212),
                Color.fromARGB(255, 89, 214, 252).withOpacity(0.7),
              ], begin: Alignment.bottomLeft, end: Alignment.topRight),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(100),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.blue.withOpacity(0.2),
                  offset: Offset(10, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CircleAvatar(

                    radius: 50,
                    backgroundImage: NetworkImage(muserlist[index].description , ),
                  ),
                  const SizedBox(height: 20,),
                  Row(

                    children: [
                      const SizedBox(width: 20,),
                      Text(muserlist[index].UserName , style: TextStyle(
                        fontSize: 25,
                      color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                      Expanded(child: Container()),

                      Icon(Icons.account_balance , color: Colors.white,),
                      const SizedBox(width: 6,),
                      Text(muserlist[index].id , style: TextStyle(
                        fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold

                      )),


                      const SizedBox(width: 20,),
                    ],

                  ),
                  const SizedBox(height: 20,),
                  Padding(padding: const EdgeInsets.all(20) ,
                    child: Text(muserlist[index].characterd , style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    ),),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "60 Minutes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              60,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(4, 5),
                                  color: Colors.blue)
                            ]),
                        child: Icon(
                          Icons.play_circle,
                          color: Colors.white,
                          size: 60,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),

                ],
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
