import 'package:flutter/cupertino.dart';

class User {
  User({
    required this.UserName,
    required this.description,
    required this.id,
    required this.characterd
  });
  late String UserName;
  late String description;
  late String id;
  late String characterd;

  User.fromJson(Map<String?, dynamic> json){
    UserName = json['UserName'];
    description = json['description'];
    id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['UserName'] = UserName;
    _data['description'] = description;
    _data['id'] = id;
    return _data;
  }
}