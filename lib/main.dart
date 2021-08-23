import 'package:flutter/material.dart';
import 'package:youtube_focus/app_config.dart';
import 'package:youtube_focus/ui/app_router.dart';
import 'app/my_app.dart';

void main() async {
  await MyApp.initSystemDefaults();
  runApp(AppConfig(
      appName: 'YouTube Focus',
      initialRoute: AppRouter.SEARCH_SCREEN,
      child: MyApp.run()));
}
