import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sembasttutorial/data/fruit.dart';

@immutable
abstract class FruitState extends Equatable {
  FruitState();

  @override
  List<Object> get props => [];
}

class FruitsLoading extends FruitState {}

class FruitsLoaded extends FruitState {
  final List<Fruit> fruits;

  FruitsLoaded(this.fruits);

  @override
  List<Object> get props => [fruits];
}