import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../game.dart';
import '../utils.dart';
import 'bat.dart';
import 'message.dart';

class Ball extends CircleComponent
    with HasGameRef<MyGame>, CollisionCallbacks, Tappable {
  bool isGameStarted = false;
  Vector2 velocity = Vector2.zero();
  late int speed;
  Message? message;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    if (kIsWeb) {
      message = Message(
          'Tap on the Ball to Play\nPlayer 1: Use W/S Keys to Play\nPlayer 2: Use ArrowUp/ArrowDown Keys to Play');
    } else {
      message = Message(
          'Tap on the Ball to Play\nPlayer 1: Use A/D Keys to Play\nPlayer 2: Use ArrowLeft/ArrowRight Keys to Play');
    }

    gameRef.add(message!);
    speed = kIsWeb ? 600 : 500;
    radius = kIsWeb ? 20 : 15;
    anchor = Anchor.center;
    position = gameRef.size / 2;
    add(CircleHitbox()
      ..renderShape = true
      ..setColor(Colors.red));
  }

  @override
  bool onTapDown(info) {
    start();
    return true;
  }

  @override
  void update(dt) {
    super.update(dt);
    position += velocity * dt;
  }

  void start() {
    if (message != null) {
      gameRef.remove(message!);
      message = null;
    }
    isGameStarted = true;
    position = gameRef.size / 2;
    final v1 = sin(getAngle()) * speed;
    final v2 = cos(getAngle()) * speed;
    velocity = Vector2(v1, v2);
  }

  void reset() {
    gameRef.player1.score = 0;
    gameRef.player2.score = 0;
    start();
  }

  @override
  void onCollisionStart(intersectionPoints, other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final collision = intersectionPoints.first;
      if (kIsWeb) {
        if (collision.y == 0 || collision.y == gameRef.size.y) {
          velocity.y = -velocity.y;
        }
        if (collision.x == 0) {
          gameRef.player2.score++;
          if (gameRef.player2.score == 3) {
            isGameStarted = false;
            message = Message('Player 2 Won\nPress enter/space to Replay');
            gameRef.add(message!);
          } else {
            start();
          }
        }
        if (collision.x == gameRef.size.x) {
          gameRef.player1.score++;
          if (gameRef.player1.score == 3) {
            isGameStarted = false;
            message = Message('Player 1 Won\nPress enter/space to Replay');
            gameRef.add(message!);
          } else {
            start();
          }
        }
      } else {
        if (collision.x == 0 || collision.x == gameRef.size.x) {
          velocity.x = -velocity.x;
        }
        if (collision.y == 0) {
          gameRef.player2.score++;
          if (gameRef.player2.score == 3) {
            isGameStarted = false;
            message = Message('Player 2 Won\nPress enter/space to Replay');
            gameRef.add(message!);
          } else {
            start();
          }
        }
        if (collision.y == gameRef.size.y) {
          gameRef.player1.score++;
          if (gameRef.player1.score == 3) {
            isGameStarted = false;
            message = Message('Player 1 Won\nPress enter/space to replay');
            gameRef.add(message!);
          } else {
            start();
          }
        }
      }
    }
    if (other is Bat) {
      velocity.x = -velocity.x * 1.01;
      velocity.y = -velocity.y * 1.01;
    }
  }
}
