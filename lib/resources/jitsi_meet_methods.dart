import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  Future<void> createNewMeeting({
    required String roomName,
    required String username,
    required String photoUrl,
    required String email,
    required bool isAudioMuted,
    required bool isVideoMuted,
    required String subject,
  }) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;

      var options = JitsiMeetingOptions(room: roomName)
        ..subject = subject
        ..userDisplayName = username
        ..userEmail = email
        ..userAvatarURL = photoUrl
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
