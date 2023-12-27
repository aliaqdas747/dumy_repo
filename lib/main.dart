import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dumy_app/Screens/auth/login_screen.dart';
import 'package:dumy_app/Screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'Screens/Splash_screen.dart';
import 'Screens/auth/sigin_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //We are storing  the FirebaseFirestore.instance in variable =_firestore for short the code and
  //we always need FirebaseFirestore.instance but this is easy to use as _firestore .it store the value of  FirebaseFirestore.instance.
  //FirebaseFirestore _firestore = FirebaseFirestore.instance;
    //delete
 // await _firestore.collection("users").doc("td9wmXLC9hZ0anURPZ26").delete();
 // print("Your doc is deleted successfully ");

 /* Map<String, dynamic> newUserData ={
 "name" : "Arman",
 "email" : "arman@gmail.com"
  };New id is here
await _firestore.collection("users").doc("").update({"email": "zakia26@gmail.com"});
print("New user is Saved");*/
/*     DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection("users").doc("td9wmXLC9hZ0anURPZ26").get();

//QuerySnapshot is not document .it contains the documents
 print(snapshot.data().toString());
*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:home_screen()

      /* (FirebaseAuth.instance.currentUser != null)?
          home_screen():Signup_Screen()*/
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10,),
              Image.asset('assets/logos/img1.png',width: 100,height: 80,),

              Image.asset('assets/logos/meta.png',width: 100,height: 80,),
            ],
          )
        ));
  }
}
