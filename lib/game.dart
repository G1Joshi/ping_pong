import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/background.dart';
import 'components/foreground.dart';
import 'components/ball.dart';
import 'components/banner.dart';
import 'components/bat.dart';
import 'components/score.dart';
import 'utils.dart';

class MyGame extends FlameGame
    with HasCollisionDetection, HasTappables, KeyboardEvents {
  bool isGameStarted = false;
  int speed = 0;
  int miss = 0;
  late Foreground foreground = Foreground();
  late Vector2 velocity1;
  late Vector2 velocity2;
  Bat? bat1;
  Bat? bat2;
  Score? points;
  Score? player1;
  Score? player2;
  late Ball ball;
  late GameBanner banner;
  late GameMode mode;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    velocity1 = Vector2.zero();
    velocity2 = Vector2.zero();
    banner = GameBanner();
    addAll([
      Background(),
      ScreenHitbox(),
      banner,
    ]);
  }

  single() {
    speed = 600;
    mode = GameMode.single;
    foreground = Foreground();
    ball = Ball();
    bat1 = Bat.top(size, mode);
    points = Score.mid(mode);
    remove(banner);
    addAll([
      foreground,
      ball,
      bat1!,
      points!,
    ]);
  }

  multiple() {
    speed = 500;
    mode = GameMode.multiple;
    foreground = Foreground();
    ball = Ball();
    bat1 = Bat.top(size, mode);
    bat2 = Bat.down(size, mode);
    player1 = Score.right(mode);
    player2 = Score.left(mode);
    remove(banner);
    addAll([
      foreground,
      ball,
      bat1!,
      bat2!,
      player1!,
      player2!,
    ]);
  }

  reset() {
    if (ball.message != null) {
      remove(ball.message!);
      ball.message = null;
    }
    if (mode == GameMode.multiple) {
      removeAll([
        foreground,
        ball,
        bat1!,
        bat2!,
        player1!,
        player2!,
      ]);
    } else {
      removeAll([
        foreground,
        ball,
        bat1!,
        points!,
      ]);
    }
    speed = 0;
    add(banner);
  }

  @override
  void update(dt) {
    super.update(dt);
    final displacement1 = velocity1 * (speed * dt);
    bat1?.position.add(displacement1);
    final displacement2 = velocity2 * (speed * dt);
    bat2?.position.add(displacement2);
  }

  @override
  KeyEventResult onKeyEvent(event, keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    if (event.logicalKey == LogicalKeyboardKey.digit1) {
      if (isKeyDown) if (speed == 0) single();
    }
    if (event.logicalKey == LogicalKeyboardKey.digit2) {
      if (isKeyDown) if (speed == 0) multiple();
    }
    if (event.logicalKey == LogicalKeyboardKey.space) {
      if (isKeyDown) if (!isGameStarted) ball.replay();
    }
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (isKeyDown) if (!isGameStarted) reset();
    }
    if (mode == GameMode.multiple) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        velocity1.y = isKeyDown && bat1!.isBeforeSpaceAvailable ? -1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        velocity1.y = isKeyDown && bat1!.isAfterSpaceAvailable ? 1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
        velocity2.y = isKeyDown && bat2!.isBeforeSpaceAvailable ? -1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
        velocity2.y = isKeyDown && bat2!.isAfterSpaceAvailable ? 1 : 0;
      }
    } else {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        velocity1.x = isKeyDown && bat1!.isBeforeSpaceAvailable ? -1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        velocity1.x = isKeyDown && bat1!.isAfterSpaceAvailable ? 1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
        velocity2.x = isKeyDown && bat2!.isBeforeSpaceAvailable ? -1 : 0;
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        velocity2.x = isKeyDown && bat2!.isAfterSpaceAvailable ? 1 : 0;
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
