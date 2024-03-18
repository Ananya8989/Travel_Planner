import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
class Day{
String name;
int done;
String trip;


Day({required this.name, required this.done, required this.trip});

setName(String n){
name = n;

}
getName(){
    return name;
}
setTrip(String p){
  trip = p;
}

setDelete(int d){
  done = d;
}

Day.fromMap(Map<String, dynamic> res)
      : name = res["name"],
      done = res["done"],
        trip = res["trip"];
 

Map<String, Object?> toMap() {
    return {'name': name, 'done': done,'trip':trip};
  }
}