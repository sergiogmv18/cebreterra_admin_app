
import 'package:cebreterra/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';


/// used to switch pages
class RoutesPath {
  static const home = '/';
  static const product = '/product';
  static const productSpecific = '/product/specific';
  static const artisan = '/artisan';
  static const artisanSpecific = '/artisan/specific';
  static const contact = '/contact';
  static const sales = '/sales';
  static const categories ='/categories';
}






final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RoutesPath.home: (BuildContext context) =>const HomeScreen(),
  RoutesPath.product : (BuildContext context) =>const HomeScreen(),
 // '/programming': (BuildContext context) => ProgrammingScreen(type: ModalRoute.of(context)!.settings.arguments as String?),

};
