import 'package:ball_collision/components/background.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'components/ball.dart';

class MyGame extends FlameGame with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Background(await loadSprite('bg.jpg'), size));
    add(ScreenHitbox());
    add(Ball(Colors.red, 20));
    add(Ball(Colors.green, 20));
  }
}
