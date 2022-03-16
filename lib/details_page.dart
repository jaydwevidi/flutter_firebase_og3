// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'User.dart';

class DetailsPage extends StatefulWidget {
  User cUser;
  DetailsPage({Key? key, required this.cUser}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late User updatedUser;

  @override
  void initState() {
    super.initState();

    updatedUser = User(
        UserName: widget.cUser.UserName,
        description: widget.cUser.description,
        id: widget.cUser.id,
        characterd: widget.cUser.characterd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        reverse: false,
        child: Padding(
          padding: EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 30),
          child: Column(
            children: [
              Hero(
                tag: widget.cUser.description + widget.cUser.id,
                child: CircleAvatar(
                  radius: 150,
                  backgroundImage: NetworkImage(widget.cUser.description),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Character Name")),
                initialValue: widget.cUser.UserName,
                onChanged: (newValue) {
                  updatedUser.UserName = newValue;
                  DatabaseReference dbRef = FirebaseDatabase.instance
                      .ref()
                      .child("aa")
                      .child(widget.cUser.id);

                  dbRef.child("username").set(updatedUser.UserName);
                  log("user Updated to $updatedUser");
                },
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration:
                    InputDecoration(label: Text("Character Description")),
                initialValue: widget.cUser.characterd,
                onChanged: (newValue) {
                  updatedUser.characterd = newValue;
                  DatabaseReference dbRef = FirebaseDatabase.instance
                      .ref()
                      .child("aa")
                      .child(widget.cUser.id);

                  dbRef.child("cd").set(updatedUser.characterd);
                  log("user Updated to $updatedUser");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
