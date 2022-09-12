import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

import '../game.dart';
import '../utils.dart';

class Score extends TextComponent with HasGameRef<MyGame> {
  Score.mid(mode)
      : player = 0,
        paint = TextPaint(
          style: const TextStyle(
            fontSize: 60,
            color: Colors.green,
            fontWeight: FontWeight.w900,
          ),
        );
  Score.right(mode)
      : player = 1,
        paint = TextPaint(
          style: const TextStyle(
            fontSize: 60,
            color: Colors.blue,
            fontWeight: FontWeight.w900,
          ),
        );
  Score.left(mode)
      : player = 2,
        paint = TextPaint(
          style: const TextStyle(
            fontSize: 60,
            color: Colors.green,
            fontWeight: FontWeight.w900,
          ),
        );

  final TextPaint paint;
  final int player;
  int score = 0;

  @override
  void onGameResize(Vector2 size) {
    if (gameRef.mode == GameMode.multiple) {
      position.setValues(
        player == 1 ? gameRef.size.x / 3 : gameRef.size.x / 1.5,
        40,
      );
    } else {
      position.setValues(
        gameRef.size.x / 2,
        40,
      );
    }
    super.onGameResize(size);
  }

  @override
  void render(Canvas canvas) {
    paint.render(canvas, '$score', Vector2.zero(), anchor: Anchor.center);
  }
}
