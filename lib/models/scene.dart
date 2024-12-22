import 'package:engine/models/cell_entity.dart';
import 'game_object.dart';

final class GameScene extends GameObject {
  final List<CellEntity> cells = [];

  GameScene({
    required super.name,
  });
}
