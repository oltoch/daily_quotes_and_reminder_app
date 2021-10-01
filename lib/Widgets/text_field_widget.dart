import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? textInputType;
  final Icon? icon;
  final VoidCallback? onIconPressed;
  final bool? autofocus, validity, readOnly;

  TextFieldWidget({
    required this.controller,
    required this.label,
    this.textInputType,
    this.icon,
    this.onIconPressed,
    this.autofocus,
    this.validity,
    this.readOnly,
  });

  InputDecoration inputDecoration() {
    return InputDecoration(
        suffixIcon: (icon != null)
            ? IconButton(
                icon: icon!,
                onPressed: onIconPressed,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color(0xff829EAC),
        hintText: label,
        hintStyle: GoogleFonts.pacifico(
          textStyle: TextStyle(fontSize: 16, color: Colors.black54),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        readOnly: readOnly == null || readOnly == false ? false : true,
        showCursor: true,
        cursorColor: Color(0xffFE904B),
        autofocus: autofocus == null || autofocus == false ? false : true,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: validity == null || validity == true
                  ? Color(0xff111111)
                  : Color(0xfff44336),
              fontSize: 18),
        ),
        controller: controller,
        keyboardType: textInputType,
        textCapitalization: TextCapitalization.sentences,
        decoration: inputDecoration());
  }
}
