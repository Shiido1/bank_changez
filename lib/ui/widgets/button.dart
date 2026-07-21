import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.buttonText,
    this.color,
    this.buttonColor,
    this.icon,
    this.letterSpace = -1,
    this.buttonHeight = 60,
    this.buttonWidth = double.infinity,
    this.isLight = true,
    this.buttonBorderColor,
    this.border = 16.0,
    this.onPressed,
    this.textStyle,
    this.isLoading = false,
    this.fontSize = 18.0,
  });
  final String? buttonText;
  final double? border;
  final double? letterSpace;
  final double? fontSize;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? color;
  final Color? buttonColor;
  final Color? buttonBorderColor;
  final bool? isLight;
  final bool? isLoading;
  final Icon? icon;
  final Function()? onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: buttonWidth!,
        height: buttonHeight!,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor!),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(border!),
              side: BorderSide(color: buttonBorderColor!, width: 1),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            SizedBox(width: 6),
            Text(
              buttonText!,
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w800,
                fontSize: fontSize!,
                letterSpacing: letterSpace,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
