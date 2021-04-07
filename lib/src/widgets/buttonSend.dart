 import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:flutter/material.dart';

Widget sendButton(Function function, {String titleText})  {
    return Container(
      //margin: EdgeInsets.only(bottom: w(10)),
      height: w(50),
      width: w(150),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
      //  shadowColor: Color.fromRGBO(206, 207, 207, 1),
        color: Colors.lightBlue,//Color.fromRGBO(9, 88, 145, 1),
        elevation: 7.0,
        child: InkWell(
          onTap: function,
          child: Center(
            child: Text(
              (titleText==null)?'Enviar':titleText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: f(20),
              ),
            ),
          ),
        ),
      ),
    );
  }