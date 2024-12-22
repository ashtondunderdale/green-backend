import 'package:engine/models/game_object.dart';

final class CellTemplate extends GameObject {
  final String body;

  CellTemplate({
    required this.body, 
    required super.name
  });
}