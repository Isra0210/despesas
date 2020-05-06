import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptativeButton({
    this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: Colors.orange,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
          )
        : FlatButton(
            shape: new RoundedRectangleBorder(
              //Colocando border radius no botão
              borderRadius: new BorderRadius.circular(20),
              side: BorderSide(
                  color: Colors.red), //Theme.of(context).primaryColor),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            onPressed: onPressed, //color: Colors.grey[100],
          );
  }
}
