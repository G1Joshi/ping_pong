import 'dart:math';

import 'package:flutter/foundation.dart';

double get getRandom {
  final angle = Random().nextInt(100) + (kIsWeb ? 600 : 400);
  return angle.toDouble();
}
