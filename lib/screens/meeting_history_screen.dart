// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/utils/utils.dart';

class MeetingHistoryScreen extends StatefulWidget {
  const MeetingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<MeetingHistoryScreen> createState() => _MeetingHistoryScreenState();
}

class _MeetingHistoryScreenState extends State<MeetingHistoryScreen> {
  var _isLoading = false;
  late String personalMeetingID;
  var meetings = [];

  @override
  void initState() {
    _isLoading = true;
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      personalMeetingID = prefs.getString('personalMeetingID')!;
      _isLoading = false;
    });
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
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Divider(height: 0),
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
                      ]),
                ),
                const SizedBox(height: 14),
                const Divider(height: 0),
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
                    : Container(
                        height: 200,
                        child: ListView.builder(
                          itemCount: meetings.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(meetings[index]),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            );
                          },
                        ),
                      ),
              ],
            ),
    );
  }
}
