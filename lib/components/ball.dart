import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'bat.dart';

class Ball extends CircleComponent with HasGameRef, CollisionCallbacks {
  late Vector2 velocity;
  late int speed;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    speed = 500;
    radius = 15.0;
    anchor = Anchor.center;
    start();
    add(CircleHitbox()
      ..renderShape = true
      ..setColor(Colors.red));
  }

  @override
  void update(dt) {
    super.update(dt);
    position += velocity * dt;
  }

  void start() {
    position = gameRef.size / 2;
    final v1 = sin(getAngle()) * speed;
    final v2 = cos(getAngle()) * speed;
    velocity = Vector2(v1, v2);
  }

  @override
  void onCollisionStart(intersectionPoints, other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final collision = intersectionPoints.first;
      if (collision.x == 0 || collision.x == gameRef.size.x) {
        velocity.x = -velocity.x;
      }
      if (collision.y == 0 || collision.y == gameRef.size.y) {
        start();
      }
    }
    if (other is Bat) {
      velocity.x = -velocity.x;
      velocity.y = -velocity.y;
    }
  }
}
