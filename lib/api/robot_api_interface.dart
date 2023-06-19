abstract class RobotInterface {
  Future<void> setPosture(String posture);
  Future<void> move(Object direction);
  String getVideoStream();
  Future<void> handleTajChi(bool isTajChiEnabled);
  Future<void> saySomething(Object audioObject);
  Future<void> getLanguage();
  Future<void> setLanguage(Object languageObject);
  Future<void> getVoice();
  Future<void> setVoice(Object voiceObject);
  Future<void> setVolume(Object volumeObject);
  Future<int> getVolume();
}
