import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:eventos_unaspht/app/app_bloc.dart';
import 'package:eventos_unaspht/app/app_widget.dart';
import 'package:flutter/material.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
