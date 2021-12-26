import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import '/page/home_page.dart';
//import '/page/user_page.dart';
//import '/utils/user_preferences.dart';
//import '/utils/user_simple_preferences.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Login & Signup';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blue.shade300,
          unselectedWidgetColor: Colors.blue.shade200,
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(Colors.white),
          ),
          colorScheme: const ColorScheme.dark()
              .copyWith(secondary: Colors.indigoAccent.withOpacity(0.8)),
        ),
        home: const HomePage(),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
