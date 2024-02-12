
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/shared/entities/button_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModelButtonMenu{



  static List<ButtonMenuCebreterra>getAllButtonMenu(){
    List<ButtonMenuCebreterra> allButton = [
      ButtonMenuCebreterra(icon: FontAwesomeIcons.store, title: 'Productos', route: RoutesPath.product),
// SALES
      ButtonMenuCebreterra(icon: FontAwesomeIcons.store,title: 'vender', route: RoutesPath.sales),
// CATEGORY
      ButtonMenuCebreterra(icon: FontAwesomeIcons.list, title: 'Categorias',route: RoutesPath.categories),
//CONTACT
      ButtonMenuCebreterra(icon: FontAwesomeIcons.comment, title: 'Comentarios', route: RoutesPath.contact),
//ARTISAN
      ButtonMenuCebreterra(icon: FontAwesomeIcons.palette, title: 'Artesanos', route: RoutesPath.artisan),
    ];
    return allButton;
  }

}