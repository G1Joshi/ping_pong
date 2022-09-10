import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Message extends TextComponent with HasGameRef {
  Message(msg) {
    text = '$msg';
    anchor = Anchor.center;
    textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: kIsWeb ? 40 : 30,
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
