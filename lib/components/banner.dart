import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../game.dart';
import 'mode.dart';

class GameBanner extends RectangleComponent with HasGameRef<MyGame> {
  @override
  Future<void>? onLoad() {
    position = Vector2(gameRef.size[0] / 2, gameRef.size[1] / 2);
    size = Vector2(gameRef.size[0] / 4, gameRef.size[1] / 4);
    anchor = Anchor.center;
    add(RectangleHitbox()
      ..renderShape = true
      ..setColor(const Color(0xff112233)));
    add(TextComponent(text: 'Select playing mode', position: Vector2(70, 20)));
    add(Mode.single());
    add(Mode.multiple());
    return super.onLoad();
  }
}
