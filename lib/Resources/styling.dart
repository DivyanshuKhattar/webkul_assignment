import 'package:dummy_assignment/Resources/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStyle{

/*
Note:
  Regular = fontWeight.400
  Normal = fontWeight.500
  SemiBold = fontWeight.600
  Bold = fontWeight.700
*/


  /// ************************ [8 pixel text] *************************

  // 8 SemiBold white text style
  static final eightSemiBoldWhiteText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 8,
      color: whiteColor,
    ),
  );

  /// ************************ [12 pixel text] *************************

  // 12 normal blue text style
  static final twelveNormalBlueText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: blueColor,
    ),
  );

  // 12 normal black text style
  static final twelveNormalBlackText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: blackColor,
    ),
  );

  // 12 semi bold green text style
  static final twelveSemiBoldGreenText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: greenColor,
    ),
  );

  /// ************************ [14 pixel text] *************************

  // 14 normal black text style
  static final fourteenNormalBlackText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: blackColor,
    ),
  );

  // 14 normal light black text style
  static final fourteenNormalLightBlackText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: blackColor.withOpacity(0.3),
    ),
  );

  // 14 normal blue text style
  static final fourteenNormalBlueText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: blueColor,
    ),
  );

  // 14 bold green text style
  static final fourteenBoldGreenText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: greenColor,
    ),
  );

  /// ************************ [16 pixel text] *************************

  // 16 SemiBold black text style
  static final sixteenSemiBoldBlackText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: blackColor,
    ),
  );

  // 16 SemiBold white text style
  static final sixteenSemiBoldWhiteText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: whiteColor,
    ),
  );

  /// ************************ [20 pixel text] *************************

  // 20 SemiBold black text style
  static final twentySemiBoldBlackText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: blackColor,
    ),
  );

  // 20 SemiBold white text style
  static final twentySemiBoldWhiteText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: whiteColor,
    ),
  );


  /// ************************ [TextFormField Border Styling] *************************
  static final textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: lightGreyColor.withOpacity(0.2),
    ),
    borderRadius: BorderRadius.circular(7),
  );

}