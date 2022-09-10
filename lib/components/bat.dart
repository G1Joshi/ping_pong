import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bat extends RectangleComponent with CollisionCallbacks {
  Bat.top(Vector2 gameSize) {
    position = Vector2(gameSize[0] / 2, gameSize[1] / 1.1);
    size = Vector2(gameSize[0] / 3, gameSize[1] / 64);
    anchor = Anchor.center;
    add(RectangleHitbox()
      ..renderShape = true
      ..setColor(Colors.green));
  }

  Bat.down(Vector2 gameSize) {
    position = Vector2(gameSize[0] / 2, gameSize[1] / 10);
    size = Vector2(gameSize[0] / 3, gameSize[1] / 64);
    anchor = Anchor.center;
    add(RectangleHitbox()
      ..renderShape = true
      ..setColor(Colors.blue));
  }
}
