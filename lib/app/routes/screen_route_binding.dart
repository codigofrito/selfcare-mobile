//Dependencies
import 'package:get/get.dart';
import 'package:selfcare/app/routes/screen_routes.dart';
import 'package:selfcare/app/screens/available_tasks_screen/binding.dart';
import 'package:selfcare/app/screens/available_tasks_screen/view.dart';
import 'package:selfcare/app/screens/home_screen/binding.dart';
import 'package:selfcare/app/screens/home_screen/view.dart';
import 'package:selfcare/app/screens/landing_page_screen/binding.dart';
import 'package:selfcare/app/screens/landing_page_screen/view.dart';
import 'package:selfcare/app/screens/sign_in_screen/binding.dart';
import 'package:selfcare/app/screens/sign_in_screen/view.dart';
import 'package:selfcare/app/screens/splash_screen/binding.dart';
import 'package:selfcare/app/screens/splash_screen/view.dart';
import 'package:selfcare/app/screens/user_task_details_screen/binding.dart';
import 'package:selfcare/app/screens/user_task_details_screen/view.dart';

abstract class ScreenRouteBinding {
  static const INITIAL = ScreenRoutes.SPLASH;

  static const Transition deFaulttransition = Transition.leftToRight;

  static final screens = [
    GetPage(
      name: ScreenRoutes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashScreenBind(),
    ),
    GetPage(
      name: ScreenRoutes.HOME,
      page: () => HomeScreen(),
      binding: HomeScreenBind(),
    ),
    GetPage(
      name: ScreenRoutes.AVAILABLE_TASKS,
      page: () => AvailableTasksScreen(),
      binding: AvailableTasksScreenBind(),
    ),
    GetPage(
      name: ScreenRoutes.USER_TASK_DETAILS,
      page: () => UserTaskDetailsScreen(),
      binding: UserTaskDetailsScreenBind(),
    ),
    GetPage(
      name: ScreenRoutes.SIGN_IN,
      page: () => SignInScreen(),
      binding: SignInScreenBind(),
    ),
    GetPage(
      name: ScreenRoutes.LANDING_PAGE,
      page: () => LandingPageScreen(),
      binding: LandingPageScreenBind(),
    ),
  ];
}
