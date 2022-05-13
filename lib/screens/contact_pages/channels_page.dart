import 'package:flutter/material.dart';

class ChannelsPage extends StatefulWidget {
  const ChannelsPage({Key? key}) : super(key: key);

  @override
  State<ChannelsPage> createState() => _ChannelsPageState();
}

class _ChannelsPageState extends State<ChannelsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 5),
                Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.grey,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Contacts',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "My Contacts",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
