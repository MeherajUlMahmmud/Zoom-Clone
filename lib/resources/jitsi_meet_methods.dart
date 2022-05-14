import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class JitsiMeetMethods {
  Future<void> createNewMeeting(
      {required String roomName,
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

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
