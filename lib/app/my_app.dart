import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_focus/injection_container.dart';
import 'package:youtube_focus/ui/app_router.dart';

import '../app_config.dart';
import 'bloc_observer.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appConfig = AppConfig.of(context);

    return MaterialApp(
      initialRoute: appConfig.initialRoute,
      title: appConfig.appName,
      onGenerateRoute: AppRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }

  // add methods that are to be executed before runApp here
  static Future<void> initSystemDefaults() async {
    initKiwi();
    Bloc.observer = MyBlocObserver();
  }

  // add globally accessible dependencies/repositories here
  static Widget run() {
    return MyApp();
  }
}
