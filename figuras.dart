import 'dart:ui';
import 'package:figuras_flame/figures.dart';
import 'package:flame/components.dart';

class Mochila1 extends Mochila {
  Mochila1(
      {required super.position, required super.size, required super.paint});

  bool isCollidingWith(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}

class Caballo1 extends Caballo {
  Caballo1(
      {required super.position, required super.size, required super.paint});

  bool isCollidingWith(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}

class Caballito1 extends Caballito {
  Caballito1(
      {required super.position, required super.size, required super.paint});

  bool isCollidingWith(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}
class Puerta1 extends Puerta {
  Puerta1(
      {required super.position, required super.size, required super.paint});

  bool isCollidingWith(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}
 class Pinguino1 extends Pinguino {
  Pinguino1(
      {required super.position, required super.size, required super.paint});

  bool isCollidingWith(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}
