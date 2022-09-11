import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/background.dart';
import 'components/ball.dart';
import 'components/bat.dart';
import 'components/score.dart';

class MyGame extends FlameGame
    with HasCollisionDetection, HasTappables, KeyboardEvents {
  late final int speed;
  late final Vector2 velocity1;
  late final Vector2 velocity2;
  late final Bat bat1;
  late final Bat bat2;
  late final Score player1;
  late final Score player2;
  late final Ball ball;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    speed = kIsWeb ? 600 : 500;
    velocity1 = Vector2.zero();
    velocity2 = Vector2.zero();
    bat1 = Bat.top(size);
    bat2 = Bat.down(size);
    player1 = Score.right();
    player2 = Score.left();
    ball = Ball();
    addAll([
      Background(),
      ScreenHitbox(),
      ball,
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
    if (event.logicalKey == LogicalKeyboardKey.space ||
        event.logicalKey == LogicalKeyboardKey.enter) {
      if (isKeyDown) if (!ball.isGameStarted) ball.reset();
    }
    if (kIsWeb) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        velocity1.y = isKeyDown && bat1.isBeforeSpaceAvailable ? -1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        velocity1.y = isKeyDown && bat1.isAfterSpaceAvailable ? 1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
        velocity2.y = isKeyDown && bat2.isBeforeSpaceAvailable ? -1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
        velocity2.y = isKeyDown && bat2.isAfterSpaceAvailable ? 1 : 0;
      }
    } else {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        velocity1.x = isKeyDown && bat1.isBeforeSpaceAvailable ? -1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        velocity1.x = isKeyDown && bat1.isAfterSpaceAvailable ? 1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
        velocity2.x = isKeyDown && bat2.isBeforeSpaceAvailable ? -1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        velocity2.x = isKeyDown && bat2.isAfterSpaceAvailable ? 1 : 0;
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
