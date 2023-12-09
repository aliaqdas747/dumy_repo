import 'dart:async';

import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  void initState(){
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login_screen()));
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
      ),
    );

  }
}
