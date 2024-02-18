
import 'package:cebreterra/features/category/screen/categories_screen.dart';
import 'package:cebreterra/features/category/screen/register_category_screen.dart';
import 'package:cebreterra/features/contact/screen/contacts_screen.dart';
import 'package:cebreterra/features/home/screen/home_screen.dart';
import 'package:cebreterra/features/product/screen/details_screen.dart';
import 'package:cebreterra/features/product/screen/product_register_screen.dart';
import 'package:cebreterra/features/product/screen/products_screen.dart';
import 'package:cebreterra/shared/entities/category.dart';
import 'package:cebreterra/shared/entities/product.dart';
import 'package:flutter/material.dart';


/// used to switch pages
class RoutesPath {
  static const home = '/';
  static const product = '/product';
  static const productDetails = '/product/details';
  static const artisan = '/artisan';
  static const artisanSpecific = '/artisan/specific';
  static const contact = '/contact';
  static const sales = '/sales';
  static const categories ='/categories';
  static const editOrRegisterCategory = '/category/edit/register';
   static const editOrRegisterProduct = '/product/edit/register';
}






final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RoutesPath.home: (BuildContext context) =>const HomeScreen(),
  RoutesPath.product : (BuildContext context) =>const ProductsScreen(),
  RoutesPath.productDetails : (BuildContext context) => ProductDetailsScreen(productWk: ModalRoute.of(context)!.settings.arguments as ProductCebreterra),
  RoutesPath.contact : (BuildContext context) =>const ContactCebreterraScreen(),
  RoutesPath.categories: (BuildContext context) => const CategoryebreterraScreen(), 
  RoutesPath.editOrRegisterCategory : (BuildContext context) => RegisterCategory(currentCategoryWK: ModalRoute.of(context)!.settings.arguments as CategoryCebreterra?),
  RoutesPath.editOrRegisterProduct : (BuildContext context) => RegisterOrEditProduct(productCebreterraWk: ModalRoute.of(context)!.settings.arguments as   ProductCebreterra?),
  


};
