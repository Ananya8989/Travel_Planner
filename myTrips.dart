import 'package:flutter/material.dart';
import 'package:travel_app/database.dart';
import 'package:travel_app/trip.dart';
import 'dart:developer' as developer;
void main() {
 runApp( const Trips(title:"A",));
}

class Trips extends StatelessWidget {
  final String title;
  const Trips({required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.cyan,scaffoldBackgroundColor:Color.fromARGB(255, 249, 249, 249),
        textTheme: const TextTheme(titleMedium:TextStyle(color: Colors.white))
      ),
      home: MyTrip(title));
  }
}

class MyTrip extends StatefulWidget{
  String s = "";
  MyTrip(String t){
   s= t;
  }
  _MyTripState createState(){ 
    return new _MyTripState(s);}
}

class _MyTripState extends State<MyTrip>{
 String da = "";
   _MyTripState(String d){
    da = d;
   developer.log(da);
  }
 late DatabaseHelper dbh;
  List <Trip> tripList = [];

  TextEditingController cont1 = TextEditingController();
  TextEditingController cont2 = TextEditingController();
  @override
 void initState(){
    super.initState();
    dbh = DatabaseHelper();
    dbh.initDB().whenComplete(() async {
      setState(() {});
    });
    
  }
  
 @override
  Widget build(BuildContext context){
    return Scaffold( body:Column(
      children:<Widget>[Padding(padding: const EdgeInsets.only(top:16,bottom:5,),child:
        Container(
         child:ElevatedButton(onPressed:tripInfo, 
         child: Text("Add New Trip"),
         style:const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Color.fromARGB(255, 246, 134, 5))),),)),  
     Expanded(child:trip()),
       ]));
  }

  Widget trip(){
    return RefreshIndicator(onRefresh: _refresh,child: FutureBuilder(future:dbh.getTrip(),
     builder:(BuildContext context, AsyncSnapshot<List<Trip>> snapshot){
      developer.log(dbh.getTrip().toString());
      developer.log("Entered futureBuilder");
      developer.log(""+snapshot.data.toString());
     if(snapshot.hasData){
      developer.log("entered lol");
      return  ListView.builder(
      itemCount: snapshot.data?.length,itemBuilder: (context, i) {
         developer.log("enter Trip");
         return ElevatedButton(onPressed: filler, 
         child: IconButton(onPressed: () => dbh.deleteTrip(snapshot.data![i].name), icon: const Icon(Icons.delete_rounded)));
        }          

    );
    }
    else {
      return const Center(child: CircularProgressIndicator());
   }
 }),
  );
  
  }
   Future<void> tripInfo() async {
    String n = "";
    String t = "";
    


   return showDialog<void>(
    context: context,
    barrierDismissible: true, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('New Trip'),
        content: const SingleChildScrollView(
        ),
        actions: <Widget>[
          TextField(controller: cont1,  
            decoration: const InputDecoration( labelText: "Trip Name"), style: TextStyle(color: Colors.black),),
          TextField(controller: cont2,  
            decoration: const InputDecoration( labelText: "Trip Type"), style: TextStyle(color: Colors.black),),
          TextButton(
            child: const Text('add New Trip'),
            onPressed: () {
              if (cont1.text.isNotEmpty) {
                 n = cont1.text;}
              if (cont2.text.isNotEmpty) {
                 t = cont2.text;}
              addTrip(n,t);
              Navigator.of(context).pop();
              developer.log(n +""+t);
            },
          ),
        ],
      );
    },
  );
}
Future<void> _refresh(){
   dbh.initDB().whenComplete(() async {
      setState(() {});
    });
  return Future.delayed(const Duration(seconds:1));
 }
String filler(){
  return "";
 }

  void addTrip(String n, String t){
    developer.log("entered add");
    setState(() {
        tripList.add(Trip(name:n,type:t, delete:0));
        developer.log("added 1");
      });
      add(Trip(name:n,type:t,delete:0));
      developer.log("added 2");
       }
  Future<int> add(Trip t) async {
    developer.log("added 3");
    return await dbh.setTrip(t);
  }
  void remove(int i) {
      setState(() {
      tripList.elementAt(i).setDelete(1);
      tripList.removeAt(i);
    });
    initState();
  }


   
}