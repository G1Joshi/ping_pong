import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game.dart';
import '../utils.dart';
import 'bat.dart';
import 'game_over.dart';

class Ball extends CircleComponent with HasGameRef<MyGame>, CollisionCallbacks {
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
      if (collision.y == 0) {
        gameRef.player2.score++;
        if (gameRef.player2.score == 3) {
          gameRef.add(GameOver('Player 2 Won'));
        } else {
          start();
        }
      }
      if (collision.y == gameRef.size.y) {
        gameRef.player1.score++;
        if (gameRef.player1.score == 3) {
          gameRef.add(GameOver('Player 1 Won'));
        } else {
          start();
        }
      }
    }
    if (other is Bat) {
      velocity.x = -velocity.x * 1.01;
      velocity.y = -velocity.y * 1.01;
    }
  }
}
