import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/rendering.dart';

class DragDeslizar extends PositionComponent with DragCallbacks {
  final void Function(bool des) onDrag;

  DragDeslizar(this.onDrag) : super(anchor: Anchor.center);

  final rec = Paint()..color = Color.fromARGB(135, 9, 12, 224);
  Vector2 _dragStartPosition = Vector2.zero();

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), rec);
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _dragStartPosition = event.localPosition;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final currentPosition = event.localPosition;
    final dx = currentPosition.x - _dragStartPosition.x;
    onDrag(dx > 0);
    _dragStartPosition = currentPosition;
  }
}
