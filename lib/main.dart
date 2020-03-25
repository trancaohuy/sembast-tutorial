import 'package:flutter/material.dart';
import 'package:sembasttutorial/fruit_bloc/fruit_bloc.dart';
import 'package:sembasttutorial/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => FruitBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          accentColor: Colors.redAccent,
        ),
        home: HomePage(),
      ),
    );

  }
}
