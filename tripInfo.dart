import 'package:flutter/material.dart';
import 'package:travel_app/database.dart';
import 'package:travel_app/main.dart';
import 'dart:convert';
import 'dart:io';
import 'package:travel_app/dests.dart';
import 'package:http/http.dart';
import 'package:travel_app/trip.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';

import 'dart:developer' as developer;
void main() {
 runApp( const TripNew(title:"Australia",));
}

class TripNew extends StatelessWidget {
  final String title;
  const TripNew({required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.cyan,scaffoldBackgroundColor:Color.fromARGB(255, 249, 249, 249),
        textTheme: const TextTheme(titleMedium:TextStyle(color: Colors.black))
      ),
      home: TripInfo(title));
  }
}

class TripInfo extends StatefulWidget{
  String s = "";
  TripInfo(String t){
   s= t;
  }
  _TripInfoState createState(){ 
    return new _TripInfoState(s);}
    
}

class _TripInfoState extends State<TripInfo>{
  String da = "";
  _TripInfoState(String s){
    da = s;
    
  }

 late DatabaseHelper dbh;
  List <Dests> destList = [];

  TextEditingController cont1 = TextEditingController();
  TextEditingController contNew = TextEditingController();
   PageController _controller = PageController(initialPage: 1);
  List<int> _lenght = [0, 1, 2];
  @override
 void initState(){
    super.initState();
    dbh = DatabaseHelper();
      _controller = PageController(initialPage: 1);
    dbh.initDB().whenComplete(() async {
      setState(() {});
    });
    
  }
   @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _add() => setState(() {
        _lenght.add(_lenght.length);
      });

  void _remove() => setState(() {
        if (_lenght.length > 1) {
          _lenght.removeAt(0);
        }
      });

  void _reset() => setState(() {
        _lenght = [0, 1, 2];
      });
 @override
  Widget build(BuildContext context){
    
    return Scaffold( appBar: AppBar(backgroundColor: Colors.cyan,title:  Text(da,), centerTitle: true, toolbarHeight: 35,titleTextStyle:TextStyle(color: Colors.white, fontSize: 20),actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                icon: const Icon(Icons.refresh,color: Colors.white),
                onPressed: _reset,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0,),
              child: IconButton(
                icon: const Icon(Icons.delete_outline,color: Colors.white,),
                onPressed: _remove,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                icon: const Icon(Icons.add_box_outlined,color: Colors.white,),
                onPressed: _add,
              ),
            ),
          ],),body:Column(
      children:<Widget>[Expanded(child:
       PageView(
          controller: _controller,
          children: <Widget>[
            for (int i in _lenght)
              page(i)
          ],
        ),),
       Expanded(child:info()),
       ]));
  }
  
   Widget page(int i){
    return Scaffold(appBar: AppBar(title: Text("Day "+i.toString()),titleTextStyle:TextStyle(color: Colors.white, fontSize: 20),backgroundColor: Color.fromARGB(246, 255, 144, 40),),);
   }
  Widget info(){
    return RefreshIndicator(onRefresh: _refresh, child:FutureBuilder(future:dbh.getDest(),builder: (BuildContext context,
     AsyncSnapshot<List<Dests>> snapshot){
      developer.log(""+snapshot.hasData.toString());
      if(snapshot.hasData){
        developer.log("hasData");
      return  ListView.builder(
      itemCount: snapshot.data?.length,itemBuilder: (context, i) {
      }
      );
        }          
       else{
        return CircularProgressIndicator();
       }
    
    }
    ));
 }

 

  

Future<void> _refresh(){
   dbh.initDB().whenComplete(() async {
      setState(() {});
    });
  return Future.delayed(const Duration(seconds:1));
 }

  void destAdd(String s){
    developer.log("entered add");
    setState(() {
       destList.add(Dests(name:s,done:0,pos:0));
        developer.log("added 1");
      });
      add(Dests(name:s,done:0,pos:8));
      developer.log("added 2");
      cont1.clear();
       }
  Future<int> add(Dests d) async {
    developer.log("added 3");
    return await dbh.setDest(d);
  }
  void remove(int i) {
      setState(() {
      destList.elementAt(i).setDelete(1);
      destList.removeAt(i);
    });
    initState();
  }
   
}

