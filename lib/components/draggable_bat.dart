import 'package:ball_collision/components/bat.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

class DraggableBat extends Bat with Draggable {
  @override
  bool onDragUpdate(DragUpdateInfo info) {
    position.add(Vector2(info.delta.game[0], 0));
    return super.onDragUpdate(info);
  }
}
