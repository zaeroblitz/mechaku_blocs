import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const Color bgColor = Color(0xFFF0F0F0);
const Color pinkColor = Color(0xFFF6577C);
const Color greyColor = Color(0xFFAAAAAA);
const Color whiteColor = Color(0xFFF1F0F2);
const Color whiteColor2 = Color(0xFFFEFEFE);
const Color blackColor1 = Color(0xFF414141);
const Color blackColor2 = Color(0xFF333333);
const Color orangeColor = Color(0xFFFFA500);
const Color orangeColor2 = Color(0xFFFFB52D);
const Color secondaryColor = Color(0xFFE5E5E5);
const Color primaryFontColor = Color(0xFF515151);
// End of Colors

// Font Weights
const FontWeight bold = FontWeight.w700;
const FontWeight light = FontWeight.w300;
const FontWeight medium = FontWeight.w500;
const FontWeight regular = FontWeight.w400;
const FontWeight semiBold = FontWeight.w600;
// End of Font Weights

// Text Styles
TextStyle regularTextStyle = GoogleFonts.poppins(
  color: primaryFontColor,
);

TextStyle mediumTextStyle = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: medium,
  color: primaryFontColor,
);

TextStyle titleTextStyle = GoogleFonts.poppins(
  fontSize: 36,
  color: blackColor1,
  fontWeight: semiBold,
);

TextStyle subTitleTextStyle = GoogleFonts.poppins(
  fontSize: 22,
  color: blackColor1,
  fontWeight: semiBold,
);

TextStyle hintTextStyle = GoogleFonts.poppins(
  color: greyColor,
);

TextStyle whiteTextStyle1 = GoogleFonts.poppins(
  color: whiteColor,
);

TextStyle whiteTextStyle2 = GoogleFonts.poppins(
  color: secondaryColor,
);

TextStyle orangeTextStyle = GoogleFonts.poppins(
  color: orangeColor,
);

TextStyle pinkTextStyle = GoogleFonts.poppins(
  color: pinkColor,
);
// End of Text Styles
