import 'package:flame/components.dart';
import 'package:flame/input.dart';

import '../components/bat.dart';

class DraggableBat extends Bat with Draggable {
  DraggableBat.solo(super.gameSize) : super.solo();

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    position.add(Vector2(info.delta.game[0], 0));
    return super.onDragUpdate(info);
  }
}
