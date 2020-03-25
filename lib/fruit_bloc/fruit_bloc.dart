import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:sembasttutorial/data/fruit.dart';
import 'package:sembasttutorial/data/fruit_dao.dart';
import './bloc.dart';

class FruitBloc extends Bloc<FruitEvent, FruitState> {
  FruitDao _fruitDao = FruitDao();
  String name = '';

  // Display a loading indicator right from the start of the app
  @override
  FruitState get initialState => FruitsLoading();


  // This is where we place the logic.
  @override
  Stream<FruitState> mapEventToState(
      FruitEvent event,
      ) async* {

    print('mapEventToState');
    print(event);
    if (event is LoadFruits) {
      this.name = event.props[0];

      // Indicating that fruits are being loaded - display progress indicator.
      yield FruitsLoading();
      yield* _reloadFruits();
    }
    else if (event is AddRandomFruit) {
      // Loading indicator shouldn't be displayed while adding/updating/deleting
      // a single Fruit from the database - we aren't yielding FruitsLoading().
      await _fruitDao.insert(RandomFruitGenerator.getRandomFruit());
      yield* _reloadFruits();
    }
    else if (event is UpdateWithRandomFruit) {
      final newFruit = RandomFruitGenerator.getRandomFruit();
      // Keeping the ID of the Fruit the same
      newFruit.id = event.updatedFruit.id;
      await _fruitDao.update(newFruit);
      yield* _reloadFruits();
    }
    else if (event is DeleteFruit) {
      await _fruitDao.delete(event.fruit);
      yield* _reloadFruits();
    }
    else if (event is DebugFruit){
      await _fruitDao.debugDatabaseFruit();
    }
  }

  Stream<FruitState> _reloadFruits() async* {
    final fruits = await _fruitDao.getAllSortedByName(this.name);
    // Yielding a state bundled with the Fruits from the database.
    yield FruitsLoaded(fruits);
  }
}

class RandomFruitGenerator {
  static final _fruits = [
    Fruit(name: 'Banana', isSweet: true),
    Fruit(name: 'Strawberry', isSweet: true),
    Fruit(name: 'Kiwi', isSweet: false),
    Fruit(name: 'Apple', isSweet: true),
    Fruit(name: 'Pear', isSweet: true),
    Fruit(name: 'Lemon', isSweet: false),
  ];

  static Fruit getRandomFruit() {
    return _fruits[Random().nextInt(_fruits.length)];
  }
}
