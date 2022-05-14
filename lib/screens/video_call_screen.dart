import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_clone/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/custom_button.dart';
import 'package:zoom_clone/widgets/custom_divider.dart';
import 'package:zoom_clone/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  late TextEditingController _meetingIDController, _nameController;
  late String username, email, photoUrl;
  bool _isLoading = true;
  bool _joinBtnDisabled = true;
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    _meetingIDController = TextEditingController();
    _nameController = TextEditingController();
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _meetingIDController.dispose();
    _nameController.dispose();
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
      email = prefs.getString('email')!;
      photoUrl = prefs.getString('photoUrl')!;
      _isLoading = false;
    });
  }

  _joinMeeting() {
    // _jitsiMeetMethods.createNewMeeting(
    //   roomName: _meetingIDController.text,
    //   isAudioMuted: isAudioMuted,
    //   isVideoMuted: isVideoMuted,
    //   username: username,
    //   email: email,
    //   photoUrl: photoUrl,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Join a Meeting'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Text("Loading")
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const CustomDivider(),
                SizedBox(
                  child: TextField(
                    controller: _meetingIDController,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      fillColor: secondaryBackgroundColor,
                      filled: true,
                      hintText: 'Room ID',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (_meetingIDController.text.isNotEmpty &&
                          _meetingIDController.text.length == 8) {
                        setState(() {
                          _joinBtnDisabled = false;
                        });
                      } else {
                        setState(() {
                          _joinBtnDisabled = true;
                        });
                      }
                    },
                  ),
                ),
                const CustomDivider(),
                const SizedBox(height: 20),
                const CustomDivider(),
                SizedBox(
                  child: TextField(
                    controller: _nameController..text = username,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      fillColor: secondaryBackgroundColor,
                      filled: true,
                      hintText: 'Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const CustomDivider(),
                const SizedBox(height: 10),
                CustomButton(
                  text: "Join",
                  onPressed: _joinMeeting,
                  bgColor: blueColor,
                  disabled: _joinBtnDisabled,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                  child: Text("JOIN OPTIONS",
                  style: TextStyle(
                    color: Colors.white70,
                  ),),
                ),
                const SizedBox(height: 5),
                Container(
                  color: secondaryBackgroundColor,
                  child: Column(
                    children: [
                      const CustomDivider(),
                      MeetingOption(
                        text: 'Mute Audio',
                        isMute: isAudioMuted,
                        onChange: onAudioMuted,
                      ),
                      const CustomDivider(),
                      MeetingOption(
                        text: 'Turn Off My Video',
                        isMute: isVideoMuted,
                        onChange: onVideoMuted,
                      ),
                      const CustomDivider(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

    onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
