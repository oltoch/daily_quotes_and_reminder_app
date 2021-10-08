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
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
      fillColor: Color(0x222979ff),
      //fillColor: Color(0xff829EAC),
      hintText: label,
      hintStyle: GoogleFonts.pacifico(
          textStyle: TextStyle(fontSize: 16, color: Colors.black54)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        readOnly: readOnly == null || readOnly == false ? false : true,
        showCursor: true,
        cursorColor: Color(0xff1976d2),
        autofocus: false,
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
