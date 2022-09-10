import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/background.dart';
import 'components/ball.dart';
import 'components/bat.dart';
import 'components/score.dart';

class MyGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late final int speed;
  late final Vector2 velocity1;
  late final Vector2 velocity2;
  late final Bat bat1;
  late final Bat bat2;
  late final Score player1;
  late final Score player2;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    speed = 500;
    velocity1 = Vector2.zero();
    velocity2 = Vector2.zero();
    bat1 = Bat.top(size);
    bat2 = Bat.down(size);
    player1 = Score.right();
    player2 = Score.left();
    addAll([
      Background(await loadSprite('bg.jpg'), size),
      ScreenHitbox(),
      Ball(),
      bat1,
      bat2,
      player1,
      player2,
    ]);
  }

  @override
  void update(dt) {
    super.update(dt);
    final displacement1 = velocity1 * (speed * dt);
    bat1.position.add(displacement1);
    final displacement2 = velocity2 * (speed * dt);
    bat2.position.add(displacement2);
  }

  @override
  KeyEventResult onKeyEvent(event, keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      velocity1.x = isKeyDown ? -1 : 0;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      velocity1.x = isKeyDown ? 1 : 0;
    } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
      velocity2.x = isKeyDown ? -1 : 0;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      velocity2.x = isKeyDown ? 1 : 0;
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
