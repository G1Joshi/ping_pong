import 'package:ball_collision/components/bat.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class DraggableBat extends Bat with Draggable {
  DraggableBat.top(Vector2 gameSize) : super.top(gameSize);
  DraggableBat.down(Vector2 gameSize) : super.down(gameSize);

  @override
  Future<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  bool onDragUpdate(info) {
    position.add(Vector2(info.delta.game[0], 0));
    return super.onDragUpdate(info);
  }
}
