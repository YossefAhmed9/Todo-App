//Default TextForm-field

import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';


class DefaultTextFormField {
  //final Key? key;
  final TextInputType keyboard;
  final TextEditingController controller;
  Function? submit;
  Function? change;
  Function? tap;
  final String label;
  final OutlinedBorder border;
  final Icon prefix;
  final Function(String?)? validate;

  DefaultTextFormField(
    // this.key,
    this.submit,
    this.change,
    this.tap,
    this.validate, {
    required this.keyboard,
    required this.controller,
    required this.label,
    required this.border,
    required this.prefix,
  });
}

Widget defaultTextFormField(
  // final Key? key,
  final TextInputType keyboard,
  final TextEditingController controller,
  final Function(String?) submit,
  final Function(String?) change,
  final GestureTapCallback? tap,
  final String label,
  final InputBorder border,
  final Icon prefix,
  final FormFieldValidator<String>? validate,
) =>
    TextFormField(
      //key: key,
      keyboardType: keyboard,
      controller: controller,
      onFieldSubmitted: submit,
      onChanged: change,
      onTap: tap,
      validator: validate,

      decoration: InputDecoration(
        labelText: label,
        border: border,
        prefixIcon: prefix,
      ),
    );

//Default Button
class DefaultButton {
  final double width;
  final double height;
  final Color buttonColor;
  final Function function;
  final String text;
  final Color textColor;

  //Constructor
  DefaultButton({
    required this.width,
    required this.height,
    required this.buttonColor,
    required this.function,
    required this.text,
    required this.textColor,
  });
}

Widget defaultButton(
  final double width,
  final double height,
  final Color buttonColor,
  final Function,
  final String text,
  final Color textColor,
    final double fontSize,
    ) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: buttonColor,
      ),
      child: MaterialButton(
        onPressed: Function,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize
          ),
        ),
      ),
    );
