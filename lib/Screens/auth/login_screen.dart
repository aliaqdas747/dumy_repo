import 'package:dumy_app/Screens/auth/sigin_screen.dart';
import 'package:dumy_app/Screens/home_screen.dart';
import 'package:dumy_app/Util/ui_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController  = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email =="" || password == ""){
      Fluttertoast.showToast(msg: 'Your Email or Password is missing\nPlease Enter the required information');

      print('Please enter data');
    }else {
      UserCredential userCredential =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential!= null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> home_screen()));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [

              Colors.black,
              Color(0xFFF00172D),
              Color(0xFFF00172D),
              Color(0xFFF00172D),
             // Colors.blue.shade900,
              Color(0xFFF00172D),

            ]
          )
        ),
        child: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [SizedBox(height: 1,),
              Text('English(US)',style: TextStyle(color: Colors.white70),),
              Image.asset('assets/logos/img1.png',height: 80,width: 80,),
              Container(
                  width: 400,
                child: Column(
                  children: [
                    UiHelper.CoustomTextField(emailController, 'Email',  TextInputType.emailAddress, false),
                    SizedBox(height: 10,),
                    UiHelper.CoustomTextField(passwordController, 'Password',  TextInputType.visiblePassword, false),
                    SizedBox(height: 10,),

            UiHelper.CustomBtn(() {login();}, 'Login in '),
                    SizedBox(height: 15,),
                    Text('Forgot password?',style: TextStyle(color: Colors.white),)




                  ],
                )              ),

             UiHelper.CostomButton('Create new Account ', () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup_Screen()));
             })


            ],
          ),
        ),
      ),
    );
  }
}
