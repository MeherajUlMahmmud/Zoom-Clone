// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/utils/utils.dart';
import 'package:zoom_clone/widgets/custom_divider.dart';

import '../resources/jitsi_meet_methods.dart';

class MeetingHistoryScreen extends StatefulWidget {
  const MeetingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<MeetingHistoryScreen> createState() => _MeetingHistoryScreenState();
}

class _MeetingHistoryScreenState extends State<MeetingHistoryScreen> {
  bool _isLoading = false;
  TextEditingController _subjectController = TextEditingController();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  late String personalMeetingID, username, email, photoUrl, subject;
  late String _subjectError = '';
  var meetings = [];

  @override
  void initState() {
    _isLoading = true;
    _subjectController = TextEditingController(text: 'Meeting');
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      personalMeetingID = prefs.getString('personalMeetingID')!;
      username = prefs.getString('username')!;
      email = prefs.getString('email')!;
      photoUrl = prefs.getString('photoUrl')!;
      _isLoading = false;
    });
  }

  createNewMeeting() async {
    setState(() {
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
        elevation: 0,
        title: const Text('Meetings'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const CustomDivider(),
                const SizedBox(height: 14),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Personal Meeting ID",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            personalMeetingID,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => {
                              Clipboard.setData(
                                  ClipboardData(text: personalMeetingID)),
                              showSnackBar(
                                  context,
                                  "Meeting ID copied to clipboard",
                                  Colors.green,
                                  Colors.white,
                                  2000),
                            },
                            child: const Icon(
                              Icons.content_copy,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _showMyDialog,
                            child: Container(
                              decoration: BoxDecoration(
                                color: darkGrayColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 5,
                                bottom: 5,
                              ),
                              child: const Text("Start"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: darkGrayColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 5,
                                bottom: 5,
                              ),
                              child: const Text("Send Invitation"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: darkGrayColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 5,
                                bottom: 5,
                              ),
                              child: const Text("Edit"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const CustomDivider(),
                const SizedBox(height: 10),
                meetings.isEmpty
                    ? Column(
                        children: const [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 200,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "No Upcoming Meetings",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "The scheduled meetings will be listed here",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: meetings.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(meetings[index]),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                            );
                          },
                        ),
                      ),
              ],
            ),
    );
  }
}
