import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sembasttutorial/data/fruit.dart';

@immutable
abstract class FruitEvent extends Equatable {
  FruitEvent();

  @override
  List<Object> get props => [];
}

class LoadFruits extends FruitEvent {
  final String fruitName;

  LoadFruits(this.fruitName);

  @override
  List<Object> get props => [fruitName];
}

class AddRandomFruit extends FruitEvent {

}

class UpdateWithRandomFruit extends FruitEvent {
  final Fruit updatedFruit;

  UpdateWithRandomFruit(this.updatedFruit);
}

class DeleteFruit extends FruitEvent {
  final Fruit fruit;

  DeleteFruit(this.fruit);
}

class DebugFruit extends FruitEvent {

}