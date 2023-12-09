import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dumy_app/Util/ui_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

void saveUser(){
  String name = nameController.text.trim();
  String email = emailController.text.toString();

  nameController.clear();
  emailController.clear();

  if(name != "" || email != ""){
    Map<String ,dynamic> userData = {
      "name":name,
      "email":email,
    };
    FirebaseFirestore.instance.collection("users").add(
      userData
    );
    print('User is Created');

  }else{

  }

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Glaxy code',style: TextStyle(
              fontFamily: 'fontFamily',
              fontSize: 35
            ),),
            Container(child: Row(
              children: [
                Icon(Icons.favorite_border,size: 30,),
                SizedBox(width: 10,),
                Image.asset('assets/logos/messenger.png',width: 25,height: 25)
              ],
            )),

             
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            width: 400,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                UiHelper.CoustomTextField(nameController, 'Name', TextInputType.text, false),
                SizedBox(height: 10,),
                UiHelper.CoustomTextField(emailController, 'Email Address', TextInputType.emailAddress, false),
                SizedBox(height: 10,),
             UiHelper.CustomBtn(() {
               saveUser();



             }, 'Save'),
                SizedBox(height: 20,),
                StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.active){
                    if(snapshot.hasData && snapshot.data != null){
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                          Map<String,dynamic> userMap =    snapshot.data!.docs[index].data() as Map<String,dynamic>;
                          return ListTile(
                            title: Text(userMap["name"]),
                            subtitle: Text(userMap["email"]),
                            trailing: Icon(Icons.delete),
                          );


                          },
                        ),
                      );
                    }else{
                      return Text('No data ');
                    }
                  }else{
                    return Center(
                      child:CircularProgressIndicator() ,
                    );
                  }

                },
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
