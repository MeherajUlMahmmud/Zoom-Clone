import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/contact_screen.dart';
import 'package:zoom_clone/screens/meeting_history_screen.dart';
import 'package:zoom_clone/screens/meeting_screen.dart';
import 'package:zoom_clone/screens/more_screen.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

import '../resources/auth_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const MeetingScreen(),
    const MeetingHistoryScreen(),
    const ContactScreen(),
    const MoreScreen(),
    CustomButton(text: 'Log Out', onPressed: () => AuthMethods().signOut()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 24,
            ),
            label: 'Meet & Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time_rounded,
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.access_time_filled_rounded,
              color: Colors.white,
              size: 24,
            ),
            label: 'Meetings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box_outlined,
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.account_box_rounded,
              color: Colors.white,
              size: 24,
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 24,
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
