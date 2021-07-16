import 'package:flutter/material.dart';
import 'package:step/shared/decoration_formatting.dart';
import 'package:step/shared/textstyle.dart';

class AddTextCard extends StatelessWidget {
  final String underText;
  final String mainText;
  final String buttonText;
  final String chapterName;
  final Function onpressedFunc;
  final Color textcolor;
  final Color buttonColor;
  const AddTextCard({Key key, this.underText, this.buttonText, this.onpressedFunc, this.mainText, this.textcolor, this.buttonColor, this.chapterName})
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
                SizedBox(height: 15.0),
                Text(
                  'Add Text',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'This adds a new Text to chapter $chapterName',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    disabledBorder: inputDisabaledWithEnabledBorderDecoration,
                    enabledBorder: inputDisabaledWithEnabledBorderDecoration,
                    focusedBorder: inputFocusedBorderDecoration,
                    errorBorder: inputErrorBorderDecoration,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                      top: 16,
                      right: 16,
                    ),
                    hintText: 'Youtube Video URL',
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
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
        ],
      ),
    ));
  }
}
