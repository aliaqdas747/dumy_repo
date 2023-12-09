import 'package:flutter/material.dart';

class UiHelper{
  static CoustomTextField(          //Static function is used when we want to call this function anywhere in the app
      TextEditingController controller ,//TextEditing controller is parameter &controller is instance .
      String text,
      //String is parameter and text is its instance

      TextInputType keyboardType,
      bool toHide ){
    return Container(

      height: 50,
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10)
      ),
      child:TextField(
        cursorColor: Colors.white,
        controller: controller,
        obscureText: toHide,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white), // Set the text color of entered text to white
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white70, // Set the desired border color here
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),


    );

  }
  static CostomPrimaryBtn(
      String text,
      VoidCallbackAction voidCallbackAction
      ){
    return      InkWell(
      onTap: (){
        voidCallbackAction;
      },
      child: Container(
        width: 400,
        height: 40,

        margin: EdgeInsets.only(left: 20,right: 20,),
        child: Center(child: Text(text,style: TextStyle(color: Colors.white),)),
        decoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );

  }
static CostomButton(
    String text,
VoidCallback voidCallback,

    ){
    return  InkWell(
      onTap: (){
        voidCallback();
      },
      child: Container(
        child: Center(
          child: Text(
            text,style: TextStyle(
              color: Colors.blue.shade900
          ),
          ),
        ),
        margin: EdgeInsets.only(left: 30,right: 30,),
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(

                color: Colors.blue.shade900
            )
        ),
      ),
    );
}
  static CustomLogoBtn(
      //Add actions .......
      Image logo,
      ){
    return Container(
      width: 50,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: logo,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.blue.shade900,
        ),
      ),
    );
  }


  //Button
  static CustomBtn(
      VoidCallback voidCallback ,String text){
    return  InkWell(

      onTap: voidCallback,
      child: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.blue.shade900
        ),
        child: Center(child: Text(text,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),),
      ),
    );
  }
  static CostumAlertBox(BuildContext context,String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(onPressed: (){}, child: Text('OK'))
        ],

      );
    });
  }
}