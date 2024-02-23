import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
class Trip{
String name;
String type;
int delete;

Trip({required this.name, required this.type, required this.delete});

setName(String n){
name = n;
}
getName(){
    return name;
}
setType(String t){
  type = t;
}

setDelete(int d){
  delete = d;
}

Trip.fromMap(Map<String, dynamic> res)
      : name = res["name"],
        type = res["type"],
        delete = res["delete"];
 

Map<String, Object?> toMap() {
    return {'name': name, 'type':type, 'delete': delete};
  }
}