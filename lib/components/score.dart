import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Score extends TextComponent with HasGameRef {
  Score.right()
      : player = 1,
        paint = TextPaint(
          style: const TextStyle(
            fontSize: kIsWeb ? 60 : 30,
            color: Colors.blue,
            fontWeight: FontWeight.w900,
          ),
        );
  Score.left()
      : player = 2,
        paint = TextPaint(
          style: const TextStyle(
            fontSize: kIsWeb ? 60 : 30,
            color: Colors.green,
            fontWeight: FontWeight.w900,
          ),
        );

  final TextPaint paint;
  final int player;
  int score = 0;

  @override
  void onGameResize(Vector2 size) {
    if (kIsWeb) {
      position.setValues(
        player == 1 ? gameRef.size.x / 3 : gameRef.size.x / 1.5,
        40,
      );
    } else {
      position.setValues(
        player == 1 ? 20 : gameRef.size.x - 20,
        gameRef.size.y / 2,
      );
    }
    super.onGameResize(size);
  }

  @override
  void render(Canvas canvas) {
    paint.render(canvas, '$score', Vector2.zero(), anchor: Anchor.center);
  }
}
