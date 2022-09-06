import 'package:ball_collision/components/wall.dart';
import 'package:flame/game.dart';

import 'components/background.dart';
import 'components/ball.dart';

class MyGame extends FlameGame with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Background(await loadSprite('bg.jpg'), size));
    for (double i = 0.0; i <= 900.0; i += 35.0) {
      add(Wall('|', Vector2(10.0, i)));
    }
    for (double i = 0.0; i <= 900.0; i += 35.0) {
      add(Wall('|', Vector2(410.0, i)));
    }
    add(Ball('🟢', Vector2(200.0, 450.0)));
  }
}
