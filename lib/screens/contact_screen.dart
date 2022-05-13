import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/contact_pages/channels_page.dart';
import 'package:zoom_clone/screens/contact_pages/contacts_page.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Contacts',
              ),
              Tab(
                text: 'Channels',
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            ContactsPage(),
            ChannelsPage(),
          ],
        ),
      ),
    );
  }
}
