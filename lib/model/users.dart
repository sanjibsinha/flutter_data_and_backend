import 'package:flutter/widgets.dart';
import 'user.dart';

import 'database_handler.dart';

class Users with ChangeNotifier {
  late DatabaseHandler handler;
  void addUsers() {
    handler.insertUser(users);
    handler.initializeDB().whenComplete(() {
      addUsers();
    });
    notifyListeners();
  }
}
