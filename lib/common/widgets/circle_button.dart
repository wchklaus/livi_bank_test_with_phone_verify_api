import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback? onTapCallBack;
  final Size size;
  final Color bgColor;
  final Color iconColor;
  final IconData iconData;

  CircleButton({
    this.onTapCallBack,
    required this.size,
    required this.iconData,
    this.bgColor = Colors.grey,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallBack,
      child: Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        width: size.width,
        height: size.height,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: new Icon(
            iconData,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
