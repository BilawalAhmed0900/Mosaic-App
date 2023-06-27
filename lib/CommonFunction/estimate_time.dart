import 'dart:math';

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

String estimateTime(int length, double speedInBytesPerSecond) {
  int seconds = length ~/ speedInBytesPerSecond;

  return _printDuration(Duration(seconds: seconds));
}