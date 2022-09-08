import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'bat.dart';

class Ball extends CircleComponent with HasGameRef, CollisionCallbacks {
  late Vector2 speed;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    start();
    radius = 20.0;
    anchor = Anchor.center;
    add(CircleHitbox()
      ..renderShape = true
      ..setColor(Colors.red));
  }

  @override
  void update(dt) {
    super.update(dt);
    position += speed * dt;
  }

  void start() {
    position = gameRef.size / 2;
    final v1 = sin(getAngle()) * 500;
    final v2 = cos(getAngle()) * 500;
    speed = Vector2(v1, v2);
  }

  @override
  void onCollisionStart(intersectionPoints, other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final collision = intersectionPoints.first;
      if (collision.x == 0 || collision.x == gameRef.size.x) {
        speed.x = -speed.x;
      }
      if (collision.y == 0) {
        speed.y = -speed.y;
      }
      if (collision.y == gameRef.size.y) {
        start();
      }
    }
    if (other is Bat) {
      speed.x = -speed.x;
      speed.y = -speed.y;
    }
  }
}
