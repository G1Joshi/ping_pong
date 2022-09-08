import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bat extends RectangleComponent with HasGameRef, CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(gameRef.size[0] / 2, gameRef.size[1] / 1.1);
    size = Vector2(gameRef.size[0] / 2, gameRef.size[1] / 64);
    anchor = Anchor.center;
    add(RectangleHitbox()
      ..renderShape = true
      ..setColor(Colors.green));
  }
}
