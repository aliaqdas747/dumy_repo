import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dumy_app/Util/ui_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  ///Your selected image is store in profilepic .
  File? profilepic;

  void saveUser() async{
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String ageString = ageController.text.trim();

    int age = int.parse(ageString);

    //When this code will execute  the TextField will clear
    nameController.clear();
    emailController.clear();
    ageController.clear();

    if (name != "" && email != "" && age != "" && profilepic != null) {
      ///FirebaseStorage.instance.ref(): Yeh Firebase Storage ke root ka reference hasil karta hai.
      ///.child("profilepictures"): Yeh specify karta hai ke "profilepictures" naam se ek child directory root mein banaye jaye.
      ///.child(Uuid().v1()): Yeh Uuid package ka istemal karke ek unique identifier banata hai.
      /// Isse amuman unique filenames ko ensure karne ke liye istemal hota hai.
      /// .putFile(profilepic!): Yeh profilepic file ko Firebase Storage mein upload karta hai.
      UploadTask uploadTask =
      FirebaseStorage.instance.ref().child("profilepictures").child(Uuid().v1()).putFile(profilepic!);
     StreamSubscription taskSubscription= uploadTask.snapshotEvents.listen((snapshot) {
        double percentage = snapshot.bytesTransferred/snapshot.totalBytes
        *100;
        print(percentage.toString());
      });

       TaskSnapshot taskSnapshot = await uploadTask;
     String downloadUrl= await   taskSnapshot.ref.getDownloadURL();
     taskSubscription.cancel();

      Map<String, dynamic> userData = {
        "name": name,
        "email": email,
        "age": age,
       "profilepic": downloadUrl,
        "SimpleArray": [name, email, age]
      };
      FirebaseFirestore.instance.collection("users").add(userData);
      print('User is Created');
      setState(() {
        profilepic= null;
      });
    } else {
      // Handle empty name or email
    }
  }

  void deleteUser(String documentId) {
    FirebaseFirestore.instance.collection("users").doc(documentId).delete();
    print('User is Deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '<al_basti>',
              style: TextStyle(
                fontFamily: 'fontFamily',
                fontSize: 35,
              ),
            ),
            Container(
              child: Row(
                children: [
                  Icon(Icons.favorite_border, size: 30),
                  SizedBox(width: 10),
                  Image.asset('assets/logos/messenger.png',
                      width: 25, height: 25)
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            width: 400,
            child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                InkWell(
                  onTap: () async {
                    ///When the user Tap on the Avater
                    ///Then this code will run .ImagePicker will pic image from source :ImageSource.gallery locaaly.
                    ///And this File will store in (selectedImage) in the form of XFile .But this XFile will not Directly
                    ///Show the image in UI .We will convert XFile to File
                    XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                    ///In this code when the user select img this condition check Is
                    ///the value of selectedImage not equal to null .
                    ///If condion is true then the first code will
                    if (selectedImage != null) {
                      ///In this first code The value of selectedImage now is equal to converted file(The file type will change into File)

                      File convertedFile = File(selectedImage!.path);
                      ///After that we assigning the value profilepic is equal to  converted file
                      ///converted file ma jo value or path ha wo ab profilepic ma store ho gya ha or setState call ho gai ha
                      ///SetState jub call hoti ha to wo class ko rebuild krta ha .Or ui ko update krta ha ,

                      setState(() {
                        profilepic = convertedFile;
                      });

                      print("Image is Selected");
                    } else {
                      print("Image is not Selected");
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,

                    ///Agr profile image  null  nhi ha to jo image convert ho chukki ha or profilepic ma store ha
                    ///to wo as a background image show ho jay gii.Agr null ha to Bg image bi null rhy gii.
                    backgroundImage: (profilepic != null) ? FileImage(profilepic!) : null,
                    backgroundColor: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                UiHelper.CoustomTextField(
                    nameController, 'Name', TextInputType.text, false),
                SizedBox(height: 10),
                UiHelper.CoustomTextField(emailController, 'Email Address',
                    TextInputType.emailAddress, false),
                SizedBox(height: 10),
                UiHelper.CoustomTextField(
                    ageController, "Age", TextInputType.number, false),
                SizedBox(
                  height: 10,
                ),
                UiHelper.CustomBtn(() {
                  saveUser();
                }, 'Save' ?? 'loading...'),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("age", isGreaterThan: 10)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> userMap =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              String documentId = snapshot.data!.docs[index].id;

                              return Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors
                                          .blue), // Border color blue karne ke liye
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Optional: Rounded corners
                                ),
                                child: ListTile(
                                  textColor: Colors.blue,
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(userMap["profilepic"]),
                                  ),
                                  title: Text(
                                      userMap["name"] + "(${userMap["age"]})"),
                                  subtitle: Text(userMap["email"]),
                                  trailing: InkWell(
                                      onTap: () {
                                        deleteUser(documentId);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.blue,
                                      )),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Text(
                          'No data ',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
