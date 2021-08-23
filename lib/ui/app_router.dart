import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'search/search_screen.dart';

class AppRouter {
  static const SEARCH_SCREEN = '/search-screen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SEARCH_SCREEN:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
