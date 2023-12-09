import 'package:dumy_app/Screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Util/ui_helper.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({super.key});

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final emailController = TextEditingController();
  final passswordController = TextEditingController();
  final CpasswordController = TextEditingController();

 void createAccount() async {
   String email = emailController.text.trim();
   String password = passswordController.text.trim();
   String Cpassword = CpasswordController.text.trim();

   if(email == "" || password=="" || Cpassword==""){
     print('Field is empty');

   }else if(password != Cpassword  ){
print('Password dos,t match');

   }else{
     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
     if(userCredential!= null ){
       print('User is successfully created ');
       Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen()));

     }
   }

 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
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
        ),child: Center(
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
                    UiHelper.CoustomTextField(passswordController, 'Password',  TextInputType.visiblePassword, false),
                    SizedBox(height: 10,),
                    UiHelper.CoustomTextField(CpasswordController, 'Conform Password',  TextInputType.visiblePassword, false),
                    SizedBox(height: 10,),
                    UiHelper.CostomButton('Sign in', () {
                    createAccount();
                 Fluttertoast.showToast(msg: 'Loading...');
                    }),
                    SizedBox(height: 15,),





                  ],
                )              ),


            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen()));
                },
                child: Text('Already have an account?',style: TextStyle(color: Colors.white),))

          ],
        ),
      ),
      ),
    );
  }
}
