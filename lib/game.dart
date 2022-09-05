import 'package:ball_collision/utils.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'components/ball.dart';
import 'constants.dart';

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      SpriteComponent()
        ..sprite = await loadSprite('bg.jpg')
        ..size = size,
    );

    final ball1 = Ball()
      ..size = Vector2(kWidth, kHeight)
      ..setColor(Colors.red)
      ..position = Vector2(kWidth, kHeight)
      ..add(move(randomDouble(1000), randomDouble(10000)))
      ..add(move(randomDouble(1000), randomDouble(10000)))
      ..add(move(randomDouble(1000), randomDouble(10000)))
      ..add(move(randomDouble(1000), randomDouble(10000)))
      ..add(move(randomDouble(1000), randomDouble(10000)));
    final ball2 = Ball()
      ..size = Vector2(kWidth, kHeight)
      ..setColor(Colors.green)
      ..position = Vector2(kWidth * 2, kHeight * 2)
      ..add(move(randomDouble(1000), randomDouble(10000)))
      ..add(move(randomDouble(1000), randomDouble(10000)))
      ..add(move(randomDouble(1000), randomDouble(10000)))
      ..add(move(randomDouble(1000), randomDouble(10000)))
      ..add(move(randomDouble(1000), randomDouble(10000)));

    final world = World()..addAll([ball1, ball2]);
    add(world);

    final camera = CameraComponent(world: world)
      ..viewfinder.visibleGameSize = Vector2(kWidth * 5, kHeight * 5)
      ..viewfinder.position = Vector2(10000, 1000)
      ..viewfinder.anchor = Anchor.topCenter;
    add(camera);
  }
}

MoveByEffect move(double x, double y) {
  return MoveByEffect(
    Vector2(x, y),
    EffectController(
      duration: 4,
      curve: Curves.linear,
      alternate: true,
      infinite: true,
      startDelay: 1,
    ),
  );
}
