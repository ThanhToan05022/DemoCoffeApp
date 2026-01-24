import 'package:get/get.dart';
import 'package:projectflutter2/pages/favorites/favorites_binding.dart';
import 'package:projectflutter2/pages/home/home_binding.dart';
import 'package:projectflutter2/pages/login/login_binding.dart';
import 'package:projectflutter2/pages/login/login_pages.dart';
import 'package:projectflutter2/pages/order/Order_pages.dart';
import 'package:projectflutter2/pages/order/history/orderHistory_binding.dart';
import 'package:projectflutter2/pages/order/history/orderHistory_pages.dart';
import 'package:projectflutter2/pages/order/order_binding.dart';
import 'package:projectflutter2/pages/profile/profile_binding.dart';
import 'package:projectflutter2/pages/profile/profile_setting_page.dart';
import 'package:projectflutter2/pages/register/register_binding.dart';
import 'package:projectflutter2/pages/register/register_pages.dart';
import 'package:get/route_manager.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/bottom_bar.dart';

class AppRoutes {
  const AppRoutes._();

  static const home = '/home';
  static const login = '/login';
  static const bottomBar = '/bottomBar';
  static const orders = '/orders';
  static const register = '/register';
  static const profile = '/profile';
  static const orderHistory = '/history';

  // static const favorites = '/favorites';
  static final routes = [
    GetPage(name: login, page: () => WelcomePage(), binding: LoginBinding()),
    GetPage(
      name: bottomBar,
      page: () => BottomBar(),
      bindings: [
        HomeBinding(),
        OrderBinding(),
        FavoritesBinding(),
        OrderhistoryBinding(),
      ],
    ),
    GetPage(name: register, page: () => Register(), binding: RegisterBinding()),
    GetPage(
      name: profile,
      page: () => SettingPage(),
      binding: ProfileBinding(),
    ),
    GetPage(name: orders, page: () => OrderPages(), binding: OrderBinding()),
    GetPage(
      name: orderHistory,
      page: () => OrderhistoryPages(),
      binding: OrderhistoryBinding(),
    ),
  ];
}
