import 'package:engine/models/game_object.dart';

final class CellEntity extends GameObject {
  final String body;
  int xPos;
  int yPos;
  
  CellEntity({
    required super.name,
    required this.body,
    required this.xPos,
    required this.yPos,
  });
}