import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/ball.dart';

class MyGame extends FlameGame with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(SpriteComponent()
      ..sprite = await loadSprite('bg.jpg')
      ..size = size);
    add(Ball('🔴', Vector2(10.0, 450.0)));
    add(Ball('🟢', Vector2(390.0, 450.0)));
  }
}
