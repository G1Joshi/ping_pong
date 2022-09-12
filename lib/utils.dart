import 'dart:math';

double get getRandom {
  final angle = Random().nextInt(100) + (600);
  return angle.toDouble();
}

enum GameMode { single, multiple }
