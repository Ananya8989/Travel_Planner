import 'package:flutter/material.dart';
import 'package:travel_app/myTrips.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData( primarySwatch: Colors.blue,),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
   void onTap(int i) {
    setState(() {
      index = i;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyan,title: const Text("Trip Planner"), centerTitle: true, toolbarHeight: 35,),body: Stack(       
        children: [
          Offstage(offstage: index != 0, child: Scaffold()),
          Offstage(offstage: index != 1, child: Scaffold()),
          Offstage(offstage: index != 2, child:MyTrip("new") ,),
        ],
       
      ),
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel_outlined),
            label: 'My Trips',
          ),
        ],
         currentIndex: index,
         selectedItemColor: Color.fromARGB(255, 238, 166, 11), unselectedItemColor: const Color.fromARGB(255, 63, 68, 81),
         onTap: onTap, 
        ),);
  }
}
