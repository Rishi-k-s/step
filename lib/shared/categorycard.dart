import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//the buttoncards in student, teacher, super admin

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  const CategoryCard({Key key, this.press, this.svgSrc, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 256.52,
        width: 179.35,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0, 17),
          //     blurRadius: 12,
          //     spreadRadius: -20,
          //     color: Colors.white60,
          //   )
          // ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: SvgPicture.asset(svgSrc),
          ),
        ),
      ),
    );
  }
}

class CategoryTextCard extends StatelessWidget {
  final String text;
  final Function press;
  final colour;
  const CategoryTextCard({Key key, this.press, this.text, this.colour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 256.52,
        width: 179.35,
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
