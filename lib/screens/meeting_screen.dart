import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/utils/constants.dart';
import 'package:zoom_clone/utils/utils.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

import '../resources/jitsi_meet_methods.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  TextEditingController _subjectController = TextEditingController();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  late String personalMeetingID, username, email, photoUrl, subject;
  late String _subjectError = '';

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController(text: 'Meeting');
  }

  @override
  void dispose() {
    _subjectController.dispose();
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  createNewMeeting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      personalMeetingID = prefs.getString('personalMeetingID')!;
      username = prefs.getString('username')!;
      email = prefs.getString('email')!;
      photoUrl = prefs.getString('photoUrl')!;
      subject = _subjectController.text;
    });

    _jitsiMeetMethods.createNewMeeting(
      roomName: personalMeetingID,
      isAudioMuted: true,
      isVideoMuted: true,
      username: username,
      email: email,
      photoUrl: photoUrl,
      subject: subject,
    );
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, VIDEO_CALL_SCREEN);
  }

  Future<void> _showMyDialog() async {
    Widget posButton = TextButton(
      child: const Text("Start Meeting"),
      onPressed: () {
        if (_subjectController.text.isEmpty) {
          setState(() {
            _subjectError = '*Meeting subject cannot be empty';
          });
          showSnackBar(context, _subjectError, Colors.red, Colors.white, 1500);
        } else {
          setState(() {
            _subjectError = "";
          });
          Navigator.of(context).pop();
          createNewMeeting();
        }
      },
    );

    Widget negButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Meeting Subject'),
      content: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextField(
          controller: _subjectController,
          decoration: const InputDecoration(
            hintText: 'Enter a meeting subject',
            border: InputBorder.none,
          ),
        ),
      ),
      actions: <Widget>[
        negButton,
        posButton,
      ],
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Meet & Chat'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeMeetingButton(
                onPressed: _showMyDialog,
                text: 'New Meeting',
                icon: Icons.videocam,
                bgColor: orangeColor,
              ),
              HomeMeetingButton(
                onPressed: () => joinMeeting(context),
                text: 'Join Meeting',
                icon: Icons.add_box_rounded,
                bgColor: blueColor,
              ),
              HomeMeetingButton(
                onPressed: () {},
                text: 'Schedule',
                icon: Icons.calendar_today,
                bgColor: blueColor,
              ),
              HomeMeetingButton(
                onPressed: () {},
                text: 'Share Screen',
                icon: Icons.arrow_upward_rounded,
                bgColor: blueColor,
              ),
            ],
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Create/Join Meetings with just a click!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
