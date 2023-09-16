import 'package:coincollect/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String? buttonText;
  final String? imageIcon;
  final IconData? icon;
  final Color? imageColour;
  final double? imageRadius;
  final Color? buttonColour;
  final EdgeInsets? padding;
  const CustomIconButton({
    Key? key,
    this.buttonText,
    this.imageIcon,
    this.icon,
    this.imageColour,
    this.imageRadius,
    this.buttonColour,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: buttonColour,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Padding(
          padding:
              padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageIcon != null
                  ? Container(
                      height: 25,
                      margin: const EdgeInsets.only(left: 20),
                      child: Image.asset(
                        imageIcon!,
                        color: imageColour,
                        height: imageRadius,
                        width: imageRadius,
                      ))
                  : Container(),
              icon != null
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        icon,
                        size: imageRadius,
                        color: imageColour ?? whiteColour,
                      ),
                    )
                  : Container(),
              const SizedBox(
                width: 10,
              ),
              buttonText != null
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        buttonText!,
                        style: TextStyle(
                          color:
                              (buttonColour == whiteColour) ? blackColour : whiteColour,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ));
  }
}
