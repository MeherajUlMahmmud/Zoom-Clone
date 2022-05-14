import 'package:flutter/material.dart';
import 'package:zoom_clone/widgets/custom_divider.dart';

class ChannelsPage extends StatefulWidget {
  const ChannelsPage({Key? key}) : super(key: key);

  @override
  State<ChannelsPage> createState() => _ChannelsPageState();
}

class _ChannelsPageState extends State<ChannelsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomDivider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
              children: const [
                SizedBox(width: 5),
                Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.grey,
                ),
                SizedBox(width: 10),
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
        const CustomDivider(),
        const Padding(
          padding: EdgeInsets.fromLTRB(8.0, 14.0, 8.0, 14.0),
          child: Text(
            "My Contacts",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const CustomDivider(),
        // dropdown
        
        const CustomDivider(),
        // dropdown
      ],
    );
  }
}
