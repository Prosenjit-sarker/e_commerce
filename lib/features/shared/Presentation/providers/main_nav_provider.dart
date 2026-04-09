import 'package:flutter/cupertino.dart';

import '../../../../app/controllers/auth_controller.dart';

class MainNavProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void moveToCategory() {
    changeIndex(1);
  }

  void backToHome() {
    changeIndex(0);
  }

  Future<bool> isAlreadyLoggedIn() async {
    return await AuthController.isUserAlreadyLoggedIn();
  }

  bool shouldVerifyLoginState(int index) {
    return index == 2 || index == 3;
  }
}
