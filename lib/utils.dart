import 'dart:math';
import 'dart:ui';

double getRandomDouble() {
  return Random().nextDouble();
}

double getAngle() {
  return lerpDouble(0, 360, getRandomDouble())!;
}
