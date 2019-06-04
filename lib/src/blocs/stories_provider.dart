import 'package:flutter/material.dart';
import 'stories_bloc.dart';
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBLoc bloc;

  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBLoc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static StoriesBLoc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }
}
