import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
class Dests{
String name;
int done;
int pos;


Dests({required this.name, required this.done, required this.pos});

setName(String n){
name = n;

}
getName(){
    return name;
}
setPos(int p){
  pos = p;
}

setDelete(int d){
  done = d;
}

Dests.fromMap(Map<String, dynamic> res)
      : name = res["name"],
      done = res["done"],
        pos = res["pos"];
 

Map<String, Object?> toMap() {
    return {'name': name, 'done': done,'pos':pos};
  }
}