import 'package:flutter/material.dart';
import 'package:story_app/routes/auth_repository.dart';
import 'package:story_app/screens/addStory_screen.dart';
import 'package:story_app/screens/detail_screen.dart';
import 'package:story_app/screens/loading_screen.dart';
import 'package:story_app/screens/map_screen.dart';

import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;
  bool isRegistered = false;
  bool isAdd = false;
  bool isDetail = false;

  MyRouterDelegate(this.authRepository)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
    print(isLoggedIn);
  }

  List<Page> historyStack = [];
  bool? isLoggedIn;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashScreen;
    } else if (isLoggedIn == true) {
      historyStack = _loggedOutStack;
    } else {
      historyStack = _loggedInStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegistered = false;
        isDetail = false;
        isAdd = false;
        notifyListeners();
        return true;
      },
    );
  }

  void onRegister() {
    isRegistered = true;
    notifyListeners();
  }

  void onLogin() {
    isRegistered = false;
    notifyListeners();
  }

  void onLogout() {
    isLoggedIn = false;
    notifyListeners();
  }

  void onLoggedIn() {
    isLoggedIn = true;
    notifyListeners();
  }

  void onAddStory() {
    isAdd = true;
    notifyListeners();
  }

  void backTo() {
    isAdd = false;
    notifyListeners();
  }

  void onDeetailStory() {
    isDetail = true;
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    /* Do Nothing */
  }

  List<Page> get _loggedInStack => [
        const MaterialPage(
          key: ValueKey('LoginPage'),
          child: LoginScreen(),
        ),
        if (isRegistered == true)
          const MaterialPage(
            key: ValueKey('RegisterPage'),
            child: RegisterPage(),
          ),
      ];
  List<Page> get _loggedOutStack => [
         MaterialPage(
          key: ValueKey('testPage'),
          child: HomeScreen(),
        ),
        if (isAdd == true)
          const MaterialPage(
            key: ValueKey('addStoryPage'),
            child: AddStoryScreen(),
          ),
        if (isDetail == true)
          const MaterialPage(
            key: ValueKey("DetailPage"),
            child: DetailScreen(),
          )
      ];
  List<Page> get _splashScreen => [
        const MaterialPage(
            key: ValueKey('loadingPage'), child: LoadingScreen()),
      ];
}
