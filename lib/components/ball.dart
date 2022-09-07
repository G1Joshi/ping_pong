import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../utils.dart';

class Ball extends CircleComponent with HasGameRef, CollisionCallbacks {
  Ball(Color color, double radius) {
    paint = Paint()..color = color;
    this.radius = radius;
  }

  late Vector2 speed;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    start();
    add(CircleHitbox(radius: radius));
  }

  @override
  void update(dt) {
    super.update(dt);
    position += speed * dt;
  }

  void start() {
    position = gameRef.size / 2;
    final v1 = math.sin(getAngle()) * 400;
    final v2 = math.cos(getAngle()) * 400;
    speed = Vector2(v1, v2);
  }

  @override
  void onCollisionStart(intersectionPoints, other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final collision = intersectionPoints.first;
      if (collision.x == 0) speed.x = -speed.x;
      if (collision.y == 0) speed.y = -speed.y;
      if (collision.x == gameRef.size.x) speed.x = -speed.x;
      if (collision.y == gameRef.size.y) speed.y = -speed.y;
    }
  }
}
