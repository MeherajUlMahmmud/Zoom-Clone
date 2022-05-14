import 'package:flutter/material.dart';
import 'package:zoom_clone/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color bgColor;
  final bool disabled;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.bgColor,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ElevatedButton(
        onPressed: disabled ? () {} : onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: disabled ? darkGrayColor : bgColor,
          minimumSize: const Size(
            double.infinity,
            50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: disabled ? darkGrayColor : bgColor,
            ),
          ),
        ),
      ),
    );
  }
}
