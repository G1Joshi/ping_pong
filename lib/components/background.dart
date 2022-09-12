import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class Background extends Component with HasGameRef<MyGame> {
  static const double width = 4.0;
  late Rect gameRect;
  final Rect rect = Vector2.zero() & Vector2(width / 2, width);
  final Paint back = Paint()..color = const Color(0xff001122);

  @override
  void onGameResize(Vector2 size) {
    gameRect = Vector2.zero() & gameRef.size;
    super.onGameResize(size);
  }

  @override
  void render(Canvas canvas) {
    canvas
      ..save()
      ..drawRect(gameRect, back);
    canvas.restore();
  }
}
