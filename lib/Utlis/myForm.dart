import 'package:flutter/material.dart';
import 'package:flutter_shop/Utlis/myColors.dart';

class myForm {
  static Widget myInputField (BuildContext context, Object initialValue, Function onChanged, {
    bool isNumber = false,
    obscureText : false,
    Function onValidate,
    Widget suffIcon,
    Widget preIcon,
}) {
    return TextFormField(
      initialValue: initialValue != null ? initialValue.toString() : '',
      decoration: filedDecoration(
        context, '',
        suffixIcon: suffIcon
      ),
      obscureText: obscureText,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,

      onChanged: (String val){
        return onChanged(val);
      },
      validator: (val){
        return onValidate(val);
      },
    );
  }
  static InputDecoration filedDecoration (
      BuildContext context, String hintText,
      {Widget suffixIcon, Widget preIcon} ) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(6),
      hintText: hintText,
      prefixIcon: preIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1
        ),
      )
    );
  }

  static Widget filedLabel (String text){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Text(
        text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  static Widget saveButton (String text, Function onTap, {Color color, Color textColor, }) {
    return Container(
      height: 50,
      width: 150,
      child: GestureDetector(
        onTap:() {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(

            border: Border.all(
              color: myColors.dustyOrange,
              style: BorderStyle.solid,
              width: 1
            ),
            color: myColors.dustyOrange,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
  static void showMessage (BuildContext context, String title, String message, String actionText, Function onPressed,) {
    showDialog(
      context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: (){
              return onPressed();
            },
              child: Text(actionText),
            )
          ],

        );
    }
    );
  }
}