import 'package:ball_collision/components/background.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/ball.dart';
import 'events/draggable_bat.dart';

class MyGame extends FlameGame
    with HasCollisionDetection, HasDraggables, KeyboardEvents {
  final Vector2 velocity = Vector2(0, 0);
  final int speed = 400;
  late final DraggableBat bat;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Background(await loadSprite('bg.jpg'), size));
    add(ScreenHitbox());
    add(Ball());
    bat = DraggableBat();
    add(bat);
  }

  @override
  void update(dt) {
    super.update(dt);
    final displacement = velocity * (speed * dt);
    bat.position.add(displacement);
  }

  @override
  KeyEventResult onKeyEvent(event, keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      velocity.x = isKeyDown ? -1 : 0;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      velocity.x = isKeyDown ? 1 : 0;
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
