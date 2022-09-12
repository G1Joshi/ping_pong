import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game.dart';
import '../utils.dart';
import 'bat.dart';
import 'message.dart';

class Ball extends CircleComponent
    with HasGameRef<MyGame>, CollisionCallbacks, Tappable {
  Vector2 velocity = Vector2.zero();
  Message? message;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    if (gameRef.mode == GameMode.multiple) {
      message = Message(
          'Tap on the ball to play\nPlayer 1: Use W/S keys to play\nPlayer 2: Use ArrowUp/ArrowDown keys to play');
    } else {
      message = Message(
          'Tap on the ball to play\nUse ArrowLeft/ArrowRight keys to play');
    }
    gameRef.add(message!);
    radius = 20;
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
    gameRef.isGameStarted = true;
    position = gameRef.size / 2;
    final list = [-getRandom, getRandom, getRandom, -getRandom];
    list.shuffle();
    velocity = Vector2(list.first, list.last);
  }

  void replay() {
    gameRef.miss = 0;
    gameRef.points?.score = 0;
    gameRef.player1?.score = 0;
    gameRef.player2?.score = 0;
    start();
  }

  @override
  void onCollisionStart(intersectionPoints, other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final collision = intersectionPoints.first;
      if (gameRef.mode == GameMode.multiple) {
        if (collision.y == 0 || collision.y == gameRef.size.y) {
          velocity.y = -velocity.y;
        }
        if (collision.x == 0) {
          gameRef.player2?.score++;
          if (gameRef.player2?.score == 3) {
            gameRef.isGameStarted = false;
            message = Message(
                'Player 2 Won\nPress space to replay\nPress enter for main menu');
            gameRef.add(message!);
          } else {
            start();
          }
        }
        if (collision.x == gameRef.size.x) {
          gameRef.player1?.score++;
          if (gameRef.player1?.score == 3) {
            gameRef.isGameStarted = false;
            message = Message(
                'Player 2 Won\nPress space to replay\nPress enter for main menu');
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
          velocity.y = -velocity.y;
        }
        if (collision.y == gameRef.size.y) {
          gameRef.miss++;
          if (gameRef.miss == 3) {
            gameRef.isGameStarted = false;
            message = Message(
                'Game over. Your score: ${gameRef.points?.score}\nPress space to replay\nPress enter for main menu');
            gameRef.add(message!);
          } else {
            start();
          }
        }
      }
    }
    if (other is Bat) {
      if (gameRef.mode == GameMode.multiple) {
        final list = [-velocity.y, velocity.y];
        list.shuffle();
        velocity.y = list.first * 1.01;
        velocity.x = -velocity.x * 1.01;
      } else {
        final list = [-velocity.x, velocity.x];
        list.shuffle();
        velocity.x = list.first * 1.01;
        velocity.y = -velocity.y * 1.01;
      }
    }
  }
}
