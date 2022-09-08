import 'package:ball_collision/components/background.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/ball.dart';
import 'components/draggable_bat.dart';

class MyGame extends FlameGame with HasCollisionDetection, HasDraggables {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Background(await loadSprite('bg.jpg'), size));
    add(ScreenHitbox());
    add(Ball());
    add(DraggableBat());
  }
}
