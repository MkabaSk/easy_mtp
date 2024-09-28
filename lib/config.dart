//set constant config here
import 'package:flutter/material.dart';

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  //width and height initialization
  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize {
    return screenWidth;
  }

  static get heightSize {
    return screenHeight;
  }

  //define spacing height
  static const spaceSmall = SizedBox(
    height: 25,
  );

  static final spaceMedium = SizedBox(
    height: screenHeight! * 0.05,
  );

  static final spaceBig = SizedBox(
    height: screenHeight! * 0.08,
  );

  static TextStyle myTileTextSlyle =  TextStyle(
     color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );


  static var focusBorder = OutlineInputBorder(
  borderSide:  BorderSide(color: Color(0xffff7f50), width: 2.0),
  borderRadius: BorderRadius.circular(8.0),
  );


  static  TextStyle mySmallTextSlyele = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    overflow: TextOverflow.ellipsis
  );

  static Color myAppBarBackgroundColor = Colors.white;


  static Color? myBackgroundColor = Colors.grey[50];


  static  Color? myIconColor = Colors.white;

  static  Color? myElementColor = Colors.black;

  static  Color? myButtonColors = Color(0xffff7f50);


}
