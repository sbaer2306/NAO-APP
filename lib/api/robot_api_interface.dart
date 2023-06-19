abstract class RobotInterface {
  Future<void> setPosture(String posture);
  Future<void> move(Object direction);
  String getVideoStream();
  Future<void> handleTajChi(bool isTajChiEnabled);
}
