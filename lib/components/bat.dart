import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class Bat extends RectangleComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  bool isBeforeSpaceAvailable = true;
  bool isAfterSpaceAvailable = true;

  Bat.top(Vector2 gameSize) {
    if (kIsWeb) {
      position = Vector2(gameSize[0] - 20, gameSize[1] / 2);
      size = Vector2(gameSize[1] / 64, gameSize[0] / 5);
    } else {
      position = Vector2(gameSize[0] / 2, gameSize[1] - 25);
      size = Vector2(gameSize[0] / 3, gameSize[1] / 64);
    }
    anchor = Anchor.center;
    add(RectangleHitbox()
      ..renderShape = true
      ..setColor(Colors.green));
  }

  Bat.down(Vector2 gameSize) {
    if (kIsWeb) {
      position = Vector2(20, gameSize[1] / 2);
      size = Vector2(gameSize[1] / 64, gameSize[0] / 5);
    } else {
      position = Vector2(gameSize[0] / 2, 25);
      size = Vector2(gameSize[0] / 3, gameSize[1] / 64);
    }
    anchor = Anchor.center;
    add(RectangleHitbox()
      ..renderShape = true
      ..setColor(Colors.blue));
  }

  @override
  void onCollisionStart(intersectionPoints, other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final collision = intersectionPoints.first;
      if (kIsWeb) {
        if (collision.y == 0) {
          isBeforeSpaceAvailable = false;
        }
        if (collision.y == gameRef.size.y) {
          isAfterSpaceAvailable = false;
        }
      } else {
        if (collision.x == 0) {
          isBeforeSpaceAvailable = false;
        }
        if (collision.x == gameRef.size.x) {
          isAfterSpaceAvailable = false;
        }
      }
    }
  }

  @override
  void onCollisionEnd(other) {
    super.onCollisionEnd(other);
    isBeforeSpaceAvailable = true;
    isAfterSpaceAvailable = true;
  }
}
