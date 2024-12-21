import 'package:engine/models/cell_entity.dart';

final class GameScene {
  final String name;
  final List<CellEntity> cells = [];

  GameScene({
    required this.name
  });
}