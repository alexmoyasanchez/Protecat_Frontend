import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Map/ui/pages/home/home_controller.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/data/data.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'Screens/Calendar/utils.dart';
import 'Screens/TasksList/TasksList_screen.dart';
Future main() async {

  initializeDateFormatting('es_ES').then((_) => runApp(MyApp()));

}


class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    getListOfTasks(tasks);
    return MaterialApp(
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/ColonyDetail':
            return MaterialPageRoute(builder: (_) => DetailPage(colonySelected));
          default:
            return null;
        }
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: Background,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}