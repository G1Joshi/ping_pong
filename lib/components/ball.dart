import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ball extends TextComponent with CollisionCallbacks {
  bool collosion = false;
  Ball(String text, Vector2 position) {
    this.text = text;
    this.position = position;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (collosion) {
      removeFromParent();
    } else {
      if (text == '🔴') {
        x++;
      } else {
        x--;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    collosion = true;
  }
}
