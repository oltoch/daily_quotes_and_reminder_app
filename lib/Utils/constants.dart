import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kBigTextStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: Color(0xff111111),
);

final kTaskStatusTextStyle = GoogleFonts.poppins(
  textStyle: TextStyle(color: Color(0xfffcfcfc), fontSize: 18),
);
final kTabLabelTextStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: Color(0xfffcfcfc),
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
  ),
);

final kButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(14.0),
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff1976d2), Color(0xff2979ff)],
    //colors: [Color(0xffFB724C), Color(0xffFE904B)],
    stops: [0.3, 0.6],
  ),
);
