import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sembasttutorial/data/fruit.dart';
import 'package:sembasttutorial/fruit_bloc/bloc.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FruitBloc _fruitBloc;

  @override
  void initState() {
    super.initState();
    // Obtaining the FruitBloc instance through BlocProvider which is an InheritedWidget
    _fruitBloc = BlocProvider.of<FruitBloc>(context);
    // Events can be passed into the bloc by calling add.
    // We want to start loading fruits right from the start.
    _fruitBloc.add(LoadFruits(''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit app'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                _fruitBloc.add(DebugFruit());
              },
              icon: Icon(Icons.settings),
              label: Text(''))
        ],
      ),

      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _fruitBloc.add(AddRandomFruit());
        },
      ),


    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      bloc: _fruitBloc,
      // Whenever there is a new state emitted from the bloc, builder runs.
      builder: (BuildContext context, FruitState state) {
        if (state is FruitsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (state is FruitsLoaded) {
          return ListView.builder(
            itemCount: state.fruits.length,
            itemBuilder: (context, index) {
              final displayedFruit = state.fruits[index];
              final String subTitle = displayedFruit.id.toString() + ' - ';

              return ListTile(
                title: Text(displayedFruit.name),
                subtitle:
                Text(subTitle + (displayedFruit.isSweet ? 'Very sweet!' : 'Sooo sour!')),
                trailing: _buildUpdateDeleteButtons(displayedFruit),
              );
            },
          );
        }
        return Scaffold();
      },
    );
  }

  Row _buildUpdateDeleteButtons(Fruit displayedFruit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _fruitBloc.add(UpdateWithRandomFruit(displayedFruit));
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            _fruitBloc.add(DeleteFruit(displayedFruit));
          },
        ),
      ],
    );
  }
}