import 'dart:math';
import 'package:figuras_flame/figures.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Drag.dart';
import 'package:flutter_application_1/TapButton.dart';
import 'dart:ui';

class MyGame extends FlameGame with KeyboardEvents {
  final figuravertical = Vector2(100, 200);
  final figurahorizontal = Vector2(200, 100);
 bool  fastandfurious = false;
  final sizedejugador = Vector2(300, 200);
  @override
  bool get debugMode => true;

  

  int veloz= 1;

  late TextComponent colision;

  late TextComponent puntostexto;

  int concolision = 0;
  int puntos = 0;

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        moverIzquierda();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        moverDerecha();
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void render(Canvas canvas) {
    final Flower flower = children.query<Flower>().first;
    final DragDeslizar drag = children.query<DragDeslizar>().first;
    flower.position = Vector2(flower.position.x, size.y - figuravertical.y);
    drag.position = Vector2(size.x / 2, size.y);

    super.render(canvas);
  }

  @override
  Future<void> onLoad() async {
    children.register<Flower>();

    await add(colision = TextComponent(
        text: 'Contador de figuras: $concolision',
        position: Vector2(0, 500)));
    await add(puntostexto =
        TextComponent(text: 'puntaje: $puntos', position: Vector2(1180, 500)));
    await super.onLoad();

    
    await add(Flower(
        position: Vector2(size.x / 2, size.y - figuravertical.y),
        paint: Paint()..color = const Color.fromARGB(255, 201, 11, 106),
        size: figuravertical));
    await add(TapButton(moverDerecha)
      ..position = Vector2(1000, 75)
      ..size = Vector2(100, 100));
    await add(TapButton(moverIzquierda)
      ..position = Vector2(350, 75)
      ..size = Vector2(100, 100));
    await add(
      DragDeslizar((des) {
        if (des) {
          moverDerecha();
        } else {
          moverIzquierda();
        }
      })
        ..position = Vector2(size.x, size.y - sizedejugador.y)
        ..size = Vector2(size.x + 10, sizedejugador.y * 1),
    );
  }

  double tpmof = 2;

  @override
  void update(double dt) {
    super.update(dt);
    double tf = Random().nextDouble();
    tpmof += dt;
    super.update(dt);
    

    if (concolision != 0 &&
        concolision % 5 == 0 &&
        !fastandfurious) {
      veloz += 1;
      fastandfurious = true;
     
      // Aumenta la velocidad de las figuras
    }
    if (concolision % 10 != 0) {
    
      fastandfurious = false;
    }

    for (Mochila1 mochila in children.query<Mochila1>()) {
      mochila.position.y += veloz; // velocidad 

      // agregar puntos si hay colision 
      final flower1 = children.query<Flower>().first;
      if (mochila.colisionxy(flower1)) {
        
        puntos += 10;
        puntostexto.text = 'puntaje: $puntos';
        concolision++;
        colision.text = 'Contador de figuras: $concolision';

        
        remove(mochila);
      }
    }
    if (tpmof >= Random().nextInt(10) + 2) {
      add(Mochila1(
          position:
              Vector2(Random().nextDouble() * (size.x - figuravertical.x), 0),
          size: Vector2(
            tf * figuravertical.x + 20,
            tf * figuravertical.y + 35,
          ),
          paint: Paint()
            ..color = HSLColor.fromAHSL(
              1,
              Random().nextDouble() * 360,
              Random().nextDouble() * 1,
              Random().nextDouble() * 0.8,
            ).toColor()));
      tpmof = 0;
    }
    for (Caballo1 caballo in children.query<Caballo1>()) {
      caballo.position.y += veloz; // velocidad 

      
      final flower1 = children.query<Flower>().first;
      if (caballo.colisionxy(flower1)) {
       
        puntos += 10;
        puntostexto.text = 'puntaje: $puntos';
        concolision++;
        colision.text = 'Contador de figuras: $concolision';

       
        remove(caballo);
      }
    }
    if (tpmof >= Random().nextInt(10) + 2) {
      add(Caballo1(
          position:
              Vector2(Random().nextDouble() * (size.x - figurahorizontal.x), 0),
          size: Vector2(
            tf * figurahorizontal.x + 15,
            tf * figurahorizontal.y + 30,
          ),
          paint: Paint()
            ..color = HSLColor.fromAHSL(
              1,
              Random().nextDouble() * 360,
              Random().nextDouble() * 1,
              Random().nextDouble() * 0.8,
            ).toColor()));
      tpmof = 0;
    }
    for (Caballito1 caballito in children.query<Caballito1>()) {
      caballito.position.y += veloz;

      
      final flower1 = children.query<Flower>().first;
      if (caballito.colisionxy(flower1)) {
        // Incrementar colision
        puntos += 10;
        puntostexto.text = 'puntaje: $puntos';
        concolision++;
        colision.text = 'Contador de figuras: $concolision';

        
        remove(caballito);
      }
    }
    if (tpmof >= Random().nextInt(10) + 2) {
      add(Caballito1(
          position:
              Vector2(Random().nextDouble() * (size.x - figuravertical.x), 0),
          size: Vector2(
            tf * figuravertical.x + 15,
            tf * figuravertical.y + 30,
          ),
          paint: Paint()
            ..color = HSLColor.fromAHSL(
              1,
              Random().nextDouble() * 360,
              Random().nextDouble() * 1,
              Random().nextDouble() * 0.8,
            ).toColor()));
      tpmof = 0;
    }
     for (Puerta1 puerta in children.query<Puerta1>()) {
      puerta.position.y += veloz;

      
      final flower1 = children.query<Flower>().first;
      if (puerta.colisionxy(flower1)) {
       
        puntos += 10;
        puntostexto.text = 'puntaje: $puntos';
        concolision++;
        colision.text = 'Contador de figuras: $concolision';

        
        remove(puerta);
      }
    }
    if (tpmof >= Random().nextInt(10) + 2) {
      add(Puerta1(
          position:
              Vector2(Random().nextDouble() * (size.x - figuravertical.x), 0),
          size: Vector2(
            tf * figuravertical.x + 15,
            tf * figuravertical.y + 30,
          ),
          paint: Paint()
            ..color = HSLColor.fromAHSL(
              1,
              Random().nextDouble() * 360,
              Random().nextDouble() * 1,
              Random().nextDouble() * 0.8,
            ).toColor()));
      tpmof = 0;
    }
    for (Pinguino1 pinguino in children.query<Pinguino1>()) {
      pinguino.position.y += veloz;

      
      final flower1 = children.query<Flower>().first;
      if (pinguino.colisionxy(flower1)) {
       
        puntos += 10;
        puntostexto.text = 'puntaje: $puntos';
        concolision++;
        colision.text = 'Contador de figuras: $concolision';

        
        remove(pinguino);
      }
    }
    if (tpmof >= Random().nextInt(10) + 2) {
      add(Pinguino1(
          position:
              Vector2(Random().nextDouble() * (size.x - figuravertical.x), 0),
          size: Vector2(
            tf * figuravertical.x + 15,
            tf * figuravertical.y + 30,
          ),
          paint: Paint()
            ..color = HSLColor.fromAHSL(
              1,
              Random().nextDouble() * 360,
              Random().nextDouble() * 1,
              Random().nextDouble() * 0.8,
            ).toColor()));
      tpmof = 0;
    }
  }

  void moverIzquierda() {
    final Flower flower = children.query<Flower>().first;
    flower.position.x -= 5;

    if (flower.position.x + flower.width < 0) {
      flower.position.x = size.x;
    }
  }

  void moverDerecha() {
    final Flower flower = children.query<Flower>().first;
    flower.position.x += 8;

    if (flower.position.x > size.x) {
      flower.position.x = -flower.size.x;
    }
  }
}
class Mochila1 extends Mochila {
  Mochila1(
      {required super.position, required super.size, required super.paint});

  bool colisionxy(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}

class Caballo1 extends Caballo {
  Caballo1(
      {required super.position, required super.size, required super.paint});

  bool colisionxy(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}

class Caballito1 extends Caballito {
  Caballito1(
      {required super.position, required super.size, required super.paint});

  bool colisionxy(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}
class Puerta1 extends Puerta {
  Puerta1(
      {required super.position, required super.size, required super.paint});

  bool colisionxy(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}
 class Pinguino1 extends Pinguino {
  Pinguino1(
      {required super.position, required super.size, required super.paint});

  bool colisionxy(PositionComponent other) {
    final Rect myRect = toRect();
    final Rect otherRect = other.toRect();
    return myRect.overlaps(otherRect);
  }
}

