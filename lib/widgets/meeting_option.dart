import 'package:flutter/material.dart';

class MeetingOption extends StatelessWidget {
  final String text;
  final bool isMute;
  final Function(bool) onChange;
  const MeetingOption({
    Key? key,
    required this.text,
    required this.isMute,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 8.0, 8.0, 8.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Switch(
          value: isMute,
          onChanged: onChange,
        ),
      ],
    );
  }
}
