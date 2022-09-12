import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class Mode extends TextComponent with HasGameRef<MyGame> {
  Mode.single()
      : player = 'Single\nPress 1',
        paint = TextPaint(
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
            fontWeight: FontWeight.w900,
          ),
        );
  Mode.multiple()
      : player = 'Multiple\nPress 2',
        paint = TextPaint(
          style: const TextStyle(
            fontSize: 30,
            color: Colors.blue,
            fontWeight: FontWeight.w900,
          ),
        );

  final TextPaint paint;
  String player;

  @override
  void onGameResize(Vector2 size) {
    position.setValues(
      player == 'Single\nPress 1' ? 70 : 270,
      120,
    );
    super.onGameResize(size);
  }

  @override
  void render(Canvas canvas) {
    paint.render(canvas, player, Vector2.zero(), anchor: Anchor.center);
  }
}
