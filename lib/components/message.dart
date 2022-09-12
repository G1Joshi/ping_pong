import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class Message extends TextComponent with HasGameRef<MyGame> {
  Message(msg) {
    text = '$msg';
    anchor = Anchor.center;
    textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  void onGameResize(Vector2 size) {
    position.setValues(gameRef.size.x / 2, gameRef.size.y / 1.3);
    super.onGameResize(size);
  }
}
