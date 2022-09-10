import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameOver extends TextComponent with HasGameRef {
  GameOver(player) {
    text = '$player';
    anchor = Anchor.center;
    textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 30,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  void onGameResize(Vector2 size) {
    position.setValues(gameRef.size.x / 2, gameRef.size.y / 2);
    super.onGameResize(size);
  }
}
