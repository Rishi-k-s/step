import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:step/shared/textstyle.dart';

class ErrorScreen extends StatelessWidget {
  final String svgAsset;
  final String underText;
  final String mainText;
  final String buttonText;
  final Function onpressedFunc;
  final Color textcolor;
  final Color buttonColor;
  const ErrorScreen({Key key, this.svgAsset, this.underText, this.buttonText, this.onpressedFunc, this.mainText, this.textcolor, this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            // margin: EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 5.0, offset: Offset(0.0, 5.0))]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 70.0,
                  width: 70.0,
                  child: SvgPicture.asset(svgAsset),
                ),
                SizedBox(height: 15.0),
                Text(
                  underText,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: textcolor,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  mainText,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
                    foregroundColor: MaterialStateProperty.all<Color>(Color(0xffffffff)),
                  ),
                  onPressed: onpressedFunc,
                  child: Text(
                    buttonText,
                    style: commontextstyle,
                  ),
                )
              ],
            ),
          ),
          // SvgPicture.asset(svgAsset),
          // SizedBox(height: 15.0),
          // Text(underText),
          // SizedBox(height: 20.0),
          // Text(mainText),
          // SizedBox(
          //   height: 20.0,
          // ),
          // TextButton(
          //   onPressed: onpressedFunc,
          //   child: Text(
          //     buttonText,
          //     style: commontextstyle,
          //   ),
          // )
        ],
      ),
    ));
  }
}
