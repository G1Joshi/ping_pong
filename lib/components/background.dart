import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Background extends Component with HasGameRef {
  static const double width = 4.0;
  late Rect gameRect;
  final Rect rect = Vector2.zero() & Vector2(width / 2, width);
  final Paint back = Paint()..color = const Color(0xff001122);
  final Paint mid = Paint()..color = Colors.grey;
  final Paint front = Paint()
    ..color = Colors.grey
    ..strokeWidth = width
    ..style = PaintingStyle.stroke;

  @override
  void onGameResize(Vector2 size) {
    gameRect = Vector2.zero() & gameRef.size;
    super.onGameResize(size);
  }

  @override
  void render(Canvas canvas) {
    if (kIsWeb) {
      canvas
        ..save()
        ..drawRect(gameRect, back)
        ..drawRect(gameRect, front)
        ..translate(gameRef.size.x / 2 - rect.width / 2, width / 2);
      for (var i = 0; i < gameRef.size.y / width; i++) {
        canvas
          ..drawRect(rect, mid)
          ..translate(0, width * 2);
      }
    } else {
      canvas
        ..save()
        ..drawRect(gameRect, back)
        ..drawRect(gameRect, front);
    }
    canvas.restore();
  }
}
