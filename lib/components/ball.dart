import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ball extends TextComponent with CollisionCallbacks {
  bool collision = false;
  Ball(String text, Vector2 position) {
    this.text = text;
    this.position = position;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    int i = 1;
    if (collision) {
      i = -1;
    }
    x -= i;
    y -= i;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    collision = !collision;
  }
}
