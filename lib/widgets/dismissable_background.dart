import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum BackgroundType { PRIMARY, SECONDARY }

class DismissableBackground extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color backgroundColor;
  final Color textColor;

  final BackgroundType align;

  DismissableBackground(
      {@required this.icon,
      @required this.text,
      @required this.backgroundColor,
      @required this.align,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Align(
        child: Row(
          mainAxisAlignment: align == BackgroundType.SECONDARY
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              color: textColor,
            ),
            Text(
              ' $text',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: align == BackgroundType.SECONDARY
                  ? TextAlign.right
                  : TextAlign.left,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: align == BackgroundType.SECONDARY
            ? Alignment.centerRight
            : Alignment.centerLeft,
      ),
    );
  }
}
