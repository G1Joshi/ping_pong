import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Wall extends TextComponent with CollisionCallbacks {
  Wall(String text, Vector2 position) {
    this.text = text;
    this.position = position;
    add(RectangleHitbox());
  }
}
